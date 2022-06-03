//
//  SpecsView.swift
//  PokeProjekt
//
//  Created by Nacho on 28.04.22.
//

import SwiftUI

struct SpecsView: View {
    
    @State var selectedPokemon: String
    @State private var isFavourite: Bool = false
    @State private var isFavoStarVisible: Bool = false
    @State private var pokeGeneralSpecs = [GeneralSpecs]()
    @State private var evolutionDetails = [EvolutionDetails]()
    
    @State private var defaults = UserDefaults.standard
    
    @Binding var isPerformingNetworkCall: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Image(selectedPokemon)
                .resizable()
                .frame(width: 150, height: 150)
        }
        
        BodyContent(selectedPokemon: $selectedPokemon, pokeGeneralSpecs: $pokeGeneralSpecs, evolutionDetails: $evolutionDetails, isPerformingNetworkCall: $isPerformingNetworkCall, didFinishLoading: $isFavoStarVisible)
        
            .navigationTitle(selectedPokemon.capitalized)
            .navigationBarTitleDisplayMode(.inline)
        
            .toolbar {
                if isFavoStarVisible {
                    let starImage = isFavourite ? "star.fill" : "star"
                    
                    Button("\(Image(systemName: starImage))", role: .destructive) {
                        isFavourite.toggle()
                        
                        let selectedFavourites = FavouritesData.init(generalSpecs: pokeGeneralSpecs, evolutionDetails: evolutionDetails)
                        
                        if isFavourite {
                            // Update with new item
                            defaults.set(true, forKey: selectedPokemon)
                            
                            PersistanceManager.updateFavoPokemons(favourite: selectedFavourites, actionType: .add) { error in
                                print(error ?? "\(selectedPokemon.capitalized) successfully added")
                                return
                            }
                        }
                        
                        if !isFavourite {
                            // Remove item
                            defaults.removeObject(forKey: selectedPokemon)
                            
                            PersistanceManager.updateFavoPokemons(favourite: selectedFavourites, actionType: .remove) { error in
                                print(error ?? "\(selectedPokemon.capitalized) successfully removed")
                                return
                            }
                        }
                    }
                    
                    .onAppear() { if defaults.bool(forKey: selectedPokemon) { isFavourite = true } }
                }
            }
    }
}


struct BodyContent: View {
    
    @Binding var selectedPokemon: String
    @Binding var pokeGeneralSpecs: [GeneralSpecs]
    @Binding var evolutionDetails: [EvolutionDetails]
    @Binding var isPerformingNetworkCall: Bool
    
    @State private var listOfMoves = [String]()
    @State private var firstEvolutionState: String = "unknown"
    @State private var secondEvolutionState = [String]()
    @State private var thirdEvolutionState = [String]()
    
    @State private var isShowingMoreMoves: Bool = false
    @Binding var didFinishLoading: Bool
    
    @State private var showingSheet = false
    @State private var buttonDissabled = false
    
    var body: some View {
        
        let showMoreShowLess = isShowingMoreMoves ? "Show Less" : "Show More"
        let previewListOfMoves = listOfMoves.prefix(5)
        let restOfMoves = listOfMoves.filter { !previewListOfMoves.contains($0) }
        
        List {
            Section() {
                HStack { Text("Weight:"); Spacer(); Text("\(pokeGeneralSpecs.first?.weight ?? 000)") }
                HStack { Text("Height:"); Spacer(); Text("\(pokeGeneralSpecs.first?.height ?? 000)") }
                HStack { Text("Base Exp:"); Spacer(); Text("\(pokeGeneralSpecs.first?.baseExperience ?? 000)") }
            } header: { Text("Basics") }
            
            
            Section() {
                ForEach(previewListOfMoves.indices, id: \.self) { i in
                    Text(previewListOfMoves[i].capitalized)
                }
                
                if isShowingMoreMoves {
                    ForEach(restOfMoves.indices, id: \.self) { i in
                        Text(restOfMoves[i].capitalized)
                    }
                }
                
                Button(showMoreShowLess) {
                    isShowingMoreMoves.toggle()
                }
            } header: { Text("Moves") }
            
            Section() {
                
                EvolutionButton(selectedPokemon: $selectedPokemon,
                                pokemonName: $firstEvolutionState,
                                isPerformingNetworkCall: $isPerformingNetworkCall,
                                spacerWidth: 0)

                ForEach($secondEvolutionState, id: \.self) { pokemonName in

                    EvolutionButton(selectedPokemon: $selectedPokemon,
                                    pokemonName: pokemonName,
                                    isPerformingNetworkCall: $isPerformingNetworkCall,
                                    spacerWidth: 20)
                }

                ForEach($thirdEvolutionState, id: \.self) { pokemonName in

                    EvolutionButton(selectedPokemon: $selectedPokemon,
                                    pokemonName: pokemonName,
                                    isPerformingNetworkCall: $isPerformingNetworkCall,
                                    spacerWidth: 40)
                }
                
            } header: { Text("Evolution Chain") }
        }
        .task {
            await isPerformingNetworkCall ? getGeneralSpecsFromNetwork() : retrieveFromPersistanceManager()
        }
    }
}

struct EvolutionButton: View {
    
    @Binding var selectedPokemon: String
    @Binding var pokemonName: String
    @Binding var isPerformingNetworkCall: Bool
    
    @State private var showingSheet: Bool = false
    @State private var buttonDissabled: Bool = false
    
    var spacerWidth: CGFloat
    
    var body: some View {
        
        HStack() {
            Spacer().frame(width: spacerWidth)
            Image(pokemonName)
            Button(pokemonName.capitalized) {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                NavigationView {
                    VStack {
                        SpecsView(selectedPokemon: pokemonName, isPerformingNetworkCall: $isPerformingNetworkCall)
                    }
                }
                .navigationTitle(pokemonName)
                .navigationBarTitleDisplayMode(.inline)
            }
            
            .disabled(buttonDissabled)
            .onAppear() {
                if selectedPokemon == pokemonName {
                    buttonDissabled = true
                }
            }
        }
    }
}


// MARK: - Network Calls

extension BodyContent {
    
    private func getGeneralSpecsFromNetwork() async {
        NetworkManager.shared.getPokemons(name: selectedPokemon) { result in
            
            switch result {
            case .success(let specs):
                pokeGeneralSpecs.append(specs)
                                        
                for item in specs.moves {
                    listOfMoves.append(item.move.name)
                }
                
                getSpecies(with: specs.species.url)
                didFinishLoading = true
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    private func getSpecies(with url: String) {
        NetworkManager.shared.getSpecies(with: url) { result in
            
            switch result {
            case .success(let poke):
                getEvolutionDetails(with: poke.evolutionChain.url)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getEvolutionDetails(with url: String) {
        NetworkManager.shared.getEvolutionDetails(with: url) { result in
            switch result {
            case .success(let poke):
                //                print(poke.chain)
                evolutionDetails.append(poke)
                
                firstEvolutionState = poke.chain.species.name
                
                for i in poke.chain.evolvesTo {
                    secondEvolutionState.append(i.species.name)
                    
                    for j in i.evolvesTo {
                        thirdEvolutionState.append(j.species.name)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func retrieveFromPersistanceManager() {
        PersistanceManager.retrievePokemons { result in
            switch result {
            case .success(let favo):
                
                // Filter the favourites array to retrieve only the selected pokemon
                let selectedPokemonFavouritesData = favo.filter {
                    $0.generalSpecs.first?.name == selectedPokemon
                }
                
                guard let firstElement = selectedPokemonFavouritesData.first else { return }
                
                // Appending elements = 1st Network call
                guard let specsElement = firstElement.generalSpecs.first else { return }
                
                pokeGeneralSpecs.append(specsElement)
                
                for item in specsElement.moves {
                    listOfMoves.append(item.move.name)
                }
                
                // Appending elements = 3rd Network call
                guard let evolutionDetailsElement = firstElement.evolutionDetails.first else { return }
                
                evolutionDetails.append(evolutionDetailsElement)

                firstEvolutionState = evolutionDetailsElement.chain.species.name

                for i in evolutionDetailsElement.chain.evolvesTo {
                    secondEvolutionState.append(i.species.name)

                    for j in i.evolvesTo {
                        thirdEvolutionState.append(j.species.name)
                    }
                }
                
                didFinishLoading = true
            
            case .failure(let error):
                print(error)
            }
        }
    }
}
