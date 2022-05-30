//
//  EvolutionDetails.swift
//  PokeProjekt
//
//  Created by Nacho on 30.05.22.
//

import Foundation

struct EvolutionDetails: Codable {
    let chain: Chain
    let id: Int
}

struct Chain: Codable {
    let evolvesTo: [Chain]
    let species: Species

    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case species
    }
}
