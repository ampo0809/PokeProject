//
//  PokeDataLocal.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import SwiftUI

struct PokeDataLocal: Identifiable, Hashable {

    var id = UUID()
    var name: String
//    var type: String?
//    var abbility: String?
//    var game: String?
//    var level: Int?
//    var image: String?

//    init(name: String, type: String, abbility: String, game: String, level: Int) {
//        self.name = name
//        self.type = type
//        self.abbility = abbility
//        self.game = game
//        self.level = level
//        self.image = name
//    }
    
    init(name: String) {
        self.name = name
//        self.image = name
    }
}
