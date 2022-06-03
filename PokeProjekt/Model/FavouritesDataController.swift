//
//  FavouritesDataController.swift
//  PokeProjekt
//
//  Created by Nacho on 03.06.22.
//

import Foundation

class FavouritesDataController: ObservableObject {
    
    @Published var favouritesData = [FavouritesData]()
    
    init(id: UUID = UUID()) {
        PersistanceManager.retrievePokemons { result in
            switch result {
            case .success(let favo):
                self.favouritesData.append(contentsOf: favo)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
