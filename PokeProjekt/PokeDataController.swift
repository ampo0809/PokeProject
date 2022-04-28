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
                
        pokeData.append( PokeDataLocal(name: "bulbasaur", type: "grass", abbility: "chlorophyll", game: "greeen", level: 11))
        pokeData.append( PokeDataLocal(name: "charmander", type: "fire", abbility: "blaze", game: "red", level: 13))
        pokeData.append( PokeDataLocal(name: "squirtle", type: "water", abbility: "rain-dish", game: "blue", level: 4))
        pokeData.append( PokeDataLocal(name: "pikachu", type: "electric", abbility: "lightning-rod", game: "yellow", level: 19))
    }
}
