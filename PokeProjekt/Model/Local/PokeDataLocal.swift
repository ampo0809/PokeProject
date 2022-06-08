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
    
    init(name: String) {
        self.name = name
    }
}
