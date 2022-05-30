//
//  SpecsView.swift
//  PokeProjekt
//
//  Created by Nacho on 28.04.22.
//

import SwiftUI

struct SpecsView: View {
    
    @State var selectedPokemon: String
    
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
 
        BodyContent(selectedPokemon: $selectedPokemon)
    }
}


struct BodyContent: View {
    
    @Binding var selectedPokemon: String
    @State private var pokeGeneralSpecs = [GeneralSpecs]()
    @State private var unknown: String = "Unknown"
    @State private var listOfMoves = [String]()
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
                ForEach((1...10), id: \.self) { Text("\($0)…") }
            } header: { Text("Evolution Chain") }
            
            
            
        }
        .task {
            await getGeneralSpecs()
//            print(pokeGeneralSpecs.first?.species.url)
            
            
        }
        
        
    }
}


//struct StretchableHeader: View {
//https://medium.com/justeattakeaway-tech/swiftui-stretchable-header-view-b244ae593832
//https://github.com/OlegTsib/StretchableHeader/blob/master/StretchableHeader/StretchableHeader.swift
//
//    var image: Image
//    var initialHeaderHeight: CGFloat = 200
//
//    var body: some View {
//
//        GeometryReader(content: { geometry in
//
//            let minY = geometry.frame(in: .local).minY
//
//            image
//                .resizable()
//                .offset(y: minY > 0 ? -minY : 0)
//                .frame(height: minY > 0 ? initialHeaderHeight + minY : initialHeaderHeight)
//                .aspectRatio(2, contentMode: .fill)
//        })
//        .frame(height: initialHeaderHeight)
//    }
//}


//extension SpecsView {
//
//    func getGeneralSpecs() {
//        NetworkManager.shared.getPokemons(name: selectedPokemon) { result in
//
//            switch result {
//            case .success(let specs):
//                DispatchQueue.main.async {
//                    pokeGeneralSpecs.append(specs)
////                    print(pokeGeneralSpecs)
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}

extension BodyContent {
    
    func getGeneralSpecs() async {
        NetworkManager.shared.getPokemons(name: selectedPokemon) { result in
            
            switch result {
            case .success(let specs):
                //                DispatchQueue.main.async {
                pokeGeneralSpecs.append(specs)
                //                print(pokeGeneralSpecs.first?.moves[0].move.name)
                
                
                for i in specs.moves {
                    listOfMoves.append(i.move.name)
                }
                //                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - TODO
/*
 - Mark as favourite
 */
