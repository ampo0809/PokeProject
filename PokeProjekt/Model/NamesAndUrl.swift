//
//  NamesAndUrl.swift
//  PokeProjekt
//
//  Created by Nacho on 28.04.22.
//

import Foundation

// Not needed for now as names and images are hardcoded
struct NamesAndUrl: Codable  {

    let count: Int
    let results: [Results]
    
    struct Results: Codable {
        let name: String
        let url: URL
    }
}
