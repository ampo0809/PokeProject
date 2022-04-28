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
                
        pokeData.append( PokeDataLocal(name: "bulbasaur", abbility: "chlorophyll", game: "greeen", level: 11))
        pokeData.append( PokeDataLocal(name: "charmander", abbility: "blaze", game: "red", level: 13))
        pokeData.append( PokeDataLocal(name: "squirtle", abbility: "rain-dish", game: "blue", level: 4))
        pokeData.append( PokeDataLocal(name: "pikachu", abbility: "lightning-rod", game: "yellow", level: 19))
    }
}
