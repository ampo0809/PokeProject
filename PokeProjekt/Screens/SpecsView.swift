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
    @State private var pokeGeneralSpecs = [GeneralSpecs]()
    @State private var evolutionDetails = [EvolutionDetails]()
    
    @State private var defaults = UserDefaults.standard
    
    var body: some View {
        VStack(alignment: .center) {
            Text(selectedPokemon.capitalized)
                .font(.title2)
                .fontWeight(.bold)
            Image(selectedPokemon)
        }
        .frame(
            maxWidth: 100,
            maxHeight: 100)
 
        BodyContent(selectedPokemon: $selectedPokemon, pokeGeneralSpecs: $pokeGeneralSpecs, evolutionDetails: $evolutionDetails)
        
            .toolbar {
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


struct BodyContent: View {
    
    @Binding var selectedPokemon: String
    @Binding var pokeGeneralSpecs: [GeneralSpecs]
    @Binding var evolutionDetails: [EvolutionDetails]
    
    @State private var listOfMoves = [String]()
    @State private var firstEvolutionState = String()
    @State private var secondEvolutionState = [String]()
    @State private var thirdEvolutionState = [String]()
    
    @State private var isShowingMoreMoves: Bool = false

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
                HStack() {
                    Image(firstEvolutionState)
                    Text(firstEvolutionState.capitalized)
                }
            
                    ForEach(secondEvolutionState, id: \.self) { i in
                        HStack() {
                        Spacer().frame(width: 20)
                        Image(i)
                        Text(i.capitalized)
                    }
                }
                
                    ForEach(thirdEvolutionState, id: \.self) { i in
                        HStack() {
                        Spacer().frame(width: 40)
                        Image(i)
                        Text(i.capitalized)
                    }
                }
            } header: { Text("Evolution Chain") }
        }
        .task {
            await getGeneralSpecs()
        }
    }
}


extension BodyContent {
    
    func getGeneralSpecs() async {
        NetworkManager.shared.getPokemons(name: selectedPokemon) { result in
            
            switch result {
            case .success(let specs):
                pokeGeneralSpecs.append(specs)

                for i in specs.moves {
                    listOfMoves.append(i.move.name)
                }
                
                getSpecies(with: specs.species.url)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSpecies(with url: String) {
        NetworkManager.shared.getSpecies(with: url) { result in
            
            switch result {
            case .success(let poke):
                getEvolutionDetails(with: poke.evolutionChain.url)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getEvolutionDetails(with url: String) {
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
}
