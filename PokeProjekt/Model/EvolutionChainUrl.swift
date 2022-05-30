//
//  EvolutionChainUrl.swift
//  PokeProjekt
//
//  Created by Nacho on 30.05.22.
//

import Foundation

struct EvolutionChainUrl: Codable {
    let evolutionChain: EvolutionChain

    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
    }
}

struct EvolutionChain: Codable {
    let url: String
}
