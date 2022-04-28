//
//  PokeDataLocal.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import SwiftUI

struct PokeDataLocal: Identifiable {

    let id = UUID()
    let name: String
    let abbility: String
    let game: String
    let level: Int
    let image: Image

    init(name: String, abbility: String, game: String, level: Int) {
        self.name = name
        self.abbility = abbility
        self.game = game
        self.level = level
        self.image = Image(name)
    }
}
