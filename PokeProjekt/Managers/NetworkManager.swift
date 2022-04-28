//
//  NetworkManager.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private var baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=100"
//    let cache = NSCache<NSString, UIImage>()
    
    // poke max count = 1125

    private init() {}
    
    func getPokemons(completed: @escaping (Result<NamesAndUrl, Error>) -> Void) {
        let endpoint = baseUrl
        
        guard let url = URL(string: endpoint) else {
//            completed(.failure("meh" as! Error))
            return
        }
    
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        
            if let _ = error {
//                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
//                completed(.failure(.invalidData))
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
            

                
                let poke = try decoder.decode(NamesAndUrl.self, from: data)
                completed(.success(poke))
                
                
            } catch {
//                completed(.failure(.invalidData))
                print(error.self)
            }
        }
        task.resume()
    }
}

