//
//  PokeDataLocal.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import SwiftUI

struct PokeDataLocal: Identifiable, Hashable {

    let id = UUID()
    let name: String
    let type: String
    let abbility: String
    let game: String
    let level: Int
    let image: String

    init(name: String, type: String, abbility: String, game: String, level: Int) {
        self.name = name
        self.type = type
        self.abbility = abbility
        self.game = game
        self.level = level
        self.image = name
    }
}
