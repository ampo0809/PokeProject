//
//  GeneralSpecs.swift
//  PokeProjekt
//
//  Created by Nacho on 25.05.22.
//
import Foundation

struct GeneralSpecs: Codable, Hashable {
    let baseExperience: Int
    let height: Int
    let moves: [Move]
    let name: String
    let species: Species
    let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case weight, height
        case baseExperience = "base_experience"
        case moves, species
    }
}

struct Species: Codable, Hashable {
    let name: String
    let url: String
}

struct Move: Codable, Hashable {
    let move: Species
}
