//
//  PokeDataController.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import UIKit

class PokeDataController: ObservableObject {
    
    fileprivate var allPokemonNames = [String]()
    @Published var pokeData: [PokeDataLocal] = []
    
    init() {
        populateAllPokemonNamesArray()
        loadPokeData()
    }
    
    // Reads all the pokémon names from an external .txt file and populates an array
    private func populateAllPokemonNamesArray() {
        
        if let allNamesURL = Bundle.main.url(forResource: "PokemonNameList", withExtension: ".txt") {
            if let allNames = try? String(contentsOf: allNamesURL) {
                allPokemonNames = allNames.components(separatedBy: "\n")
            }}
        if allPokemonNames.isEmpty {
            allPokemonNames = ["pikachu"]
        }
    }
    
    private func loadPokeData() {
        
        for name in allPokemonNames {
            pokeData.append( PokeDataLocal(name: name))
        }
    }
}
