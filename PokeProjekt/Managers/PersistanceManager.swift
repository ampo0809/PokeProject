//
//  PersistanceManager.swift
//  PokeProjekt
//
//  Created by Nacho on 31.05.22.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum Keys {
    static let favourites = "favourites"
}

enum PersistanceManager {
    
    static let defaults = UserDefaults.standard
    
    static func updateFavoPokemons(favourite: FavouritesData, actionType: PersistenceActionType, completed: @escaping (PokeError?) -> Void) {
        
        retrievePokemons { result in
            switch result {
            case .success(let favourites):
                var retrievedFavourites = favourites
                
                switch actionType {
                case .add:
                    guard !retrievedFavourites.contains(favourite) else {
                        return
                    }
                    retrievedFavourites.append(favourite)
 
                case .remove:
                    retrievedFavourites.removeAll { $0.hashValue == favourite.hashValue }
                }
                
                completed(addPokemon(add: retrievedFavourites))
                
            case .failure(let error):
                completed(error)
            }
        }
        
        let obj = defaults.object(forKey: Keys.favourites) as! Data
        let str = String(decoding: obj, as: UTF8.self)
        print(str)
    }

    
    static func retrievePokemons(completed: @escaping (Result<[FavouritesData], PokeError>) -> Void) {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([FavouritesData].self, from: favouritesData)
            completed(.success(favourites))

        } catch {
            completed(.failure(.unableToAddFavourite))
        }
    }
    
    static func addPokemon(add pokemonData: [FavouritesData]) -> PokeError? {
        do {
            let encoder = JSONEncoder()
            let encodedPokemons = try encoder.encode(pokemonData)
            defaults.set(encodedPokemons, forKey: Keys.favourites)
            return nil
            
        } catch {
            return .unableToAddFavourite
        }
    }
}
