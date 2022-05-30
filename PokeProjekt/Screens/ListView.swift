//
//  ListView.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import SwiftUI

struct ListView: View {
    
    @State var pokeData: [PokeDataLocal]
    
    var body: some View {
        
        List(pokeData.indices, id: \.self) { i in
            // id mandatory when using .indices
            
            NavigationLink(destination: SpecsView(selectedPokemon: pokeData[i].name!)) {
                ReusableRow(pokeData: pokeData[i], dexCount: i+1)
            }
        }
    }
}


fileprivate struct ReusableRow: View {
    
    @State var pokeData: PokeDataLocal
    @State var dexCount: Int
    
    var body: some View {
        HStack() {
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


