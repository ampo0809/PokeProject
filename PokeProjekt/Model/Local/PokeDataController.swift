//
//  PokeDataController.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import UIKit

class PokeDataController: ObservableObject {
    
    @Published var pokeData: [PokeDataLocal] = []
    
    init() { loadPokeData() }
    
    private func loadPokeData() {
        
        for name in NamesArray.names {
            pokeData.append( PokeDataLocal(name: name))
        }
    }
}
