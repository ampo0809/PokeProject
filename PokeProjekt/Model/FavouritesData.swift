//
//  FavouritesData.swift
//  PokeProjekt
//
//  Created by Nacho on 31.05.22.
//

import Foundation
import SwiftUI

struct FavouritesData: Codable, Hashable {
    
    let generalSpecs: [GeneralSpecs]
    let evolutionDetails: [EvolutionDetails]
    
    init (generalSpecs: [GeneralSpecs],
          evolutionDetails: [EvolutionDetails]
    ){
        self.generalSpecs = generalSpecs
        self.evolutionDetails = evolutionDetails
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(generalSpecs.hashValue)
    }
    
    static func == (lhs: FavouritesData, rhs: FavouritesData) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

//    let listOfMoves: [String]
//    let firstEvolutionState: String
//    let secondEvolutionState: [String]
//    let thirdEvolutionState: [String]
//
//    init (generalSpecs: GeneralSpecs,
//          listOfMoves: [String],
//          firstEvolutionState: String,
//          secondEvolutionState: [String],
//          thirdEvolutionState: [String]
//    ){
//        self.generalSpecs = generalSpecs
//        self.listOfMoves = listOfMoves
//        self.firstEvolutionState = firstEvolutionState
//        self.secondEvolutionState = secondEvolutionState
//        self.thirdEvolutionState = thirdEvolutionState
//    }
    
}
