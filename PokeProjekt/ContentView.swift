//
//  ContentView.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var pdc = PokeDataController()
    @State var viewIndex: Int = 0
    
    var body: some View {

        if(viewIndex == 0) { ListView(pokeData: pdc.pokeData, viewIndex: $viewIndex) }
        if(viewIndex == 1) { SpecsView() }

//        SpecsView()
        
//            .onAppear {
//
//                NetworkManager.shared.getPokemons { result in
//
//                    switch result {
//                    case .success(let poke):
//
//                        print(poke.results.count)
//                        
//                    
//
////                        for i in 0..<poke.results.count {
////                            print("\"\(poke.results[i].name)\",")
////                        }
//
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//
//            }
        
   
    }
}
    
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

