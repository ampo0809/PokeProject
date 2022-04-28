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
        
        VStack() {
//            Text(pokeData[0].name)
            
//            ForEach(pokeData) { item in
//                ReusableRow(pokeData: item)
//            }
            
        
            
        }
//        List {
//            ReusableRow(pokeData: pokeData[0])
//            ForEach(pokeData) { item in
//                            ReusableRow(pokeData: item)
//                        }
//
//        }
        
        List(pokeData) { item in
            ReusableRow(pokeData: item)
            
            
        }
        
        
    }
}


fileprivate struct ReusableRow: View {
    
    @State var pokeData: PokeDataLocal
    
    var body: some View {
        HStack() {
            pokeData.image
            Text(pokeData.name.capitalized)
        }
        
        let _ = NetworkManager.shared.getPokemons { result in
            
            switch result {
            case .success(let poke):
                print(poke.results)
            case .failure(let error):
                print(error)
            }
            
        }

    }
}

