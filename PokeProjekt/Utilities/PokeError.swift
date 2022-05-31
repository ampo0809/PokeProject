//
//  PokeError.swift
//  PokeProjekt
//
//  Created by Nacho on 24.05.22.
//

import Foundation

enum PokeError: String, Error {
    case invalidName = "This Pokémon name is invalid, please try another one."
    case unableToComplete = "Unable to complete request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server, please try again."
    case invalidData = "The data received from the server was invalid"
    case unableToAddFavourite = "Sorry, this Pokémon could not be added to favourites."
    case alreadyInFavourites = "This Pókemon is already in your favourites list."
}
