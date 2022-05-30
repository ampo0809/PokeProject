//
//  ListView.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import SwiftUI

struct ListView: View {
    
    @State var pokeData: [PokeDataLocal]
    @Binding var viewIndex: Int
    
    var body: some View {
        
        NavigationView {
            VStack() {
                List(pokeData.indices, id: \.self) { i in
                    // id mandatory when using .indices
                    
                    NavigationLink(destination: SpecsView(selectedPokemon: pokeData[i].name!)) {
                        ReusableRow(pokeData: pokeData[i], dexCount: i+1)
                    }
                }
            }
            .navigationTitle("Pokédex")
            .toolbar {
                
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    
                    Spacer()
                    Button("\(Image(systemName: "sparkle.magnifyingglass"))", role: .destructive) {
                        print("Search pressed")
                        
                    }
                    
                    Spacer()
                    Button("\(Image(systemName: "star.circle"))", role: .destructive) {
                        print("Favourites presseed")
                    }
                    
                    Spacer()
                    Button("\(Image(systemName: "rotate.3d"))", role: .destructive) {
                        print("Paper plane presseed")
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        //Not sure what this does, but silences an annoying error: https://stackoverflow.com/questions/65316497/
    }
}


fileprivate struct ReusableRow: View {
    
    @State var pokeData: PokeDataLocal
    @State var dexCount: Int
    
    var body: some View {
        HStack() {
            
            //            Text(String(dexCount))
            Image(pokeData.image ?? "Unknown")
            
            HStack {
                Text(pokeData.name!.capitalized)
                    .font(.title3)
                Spacer()
                //                Text(pokeData.type?.capitalized ?? "")
                //                    .font(.footnote)
                Text(String(dexCount))
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
        }
        
    }
}


