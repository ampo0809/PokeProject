//
//  NamesAndUrl.swift
//  PokeProjekt
//
//  Created by Nacho on 28.04.22.
//

import Foundation

struct NamesAndUrl: Codable  {

    let count: Int
    let results: [Results]
    
    struct Results: Codable {
        let name: String
        let url: URL
    }
}
