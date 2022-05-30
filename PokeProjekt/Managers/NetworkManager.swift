//
//  NetworkManager.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import UIKit

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    fileprivate var baseUrl = "https://pokeapi.co/api/v2/"
    fileprivate var speciesUrl = String()
    fileprivate var evolutionChainUrl = String()

    private init() {}
    
    func getPokemons(name: String, completed: @escaping (Result<GeneralSpecs, PokeError>) -> Void) {
        let endpoint = baseUrl + "pokemon/\(name)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidName))
            return
        }
    
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let poke = try decoder.decode(GeneralSpecs.self, from: data)
                completed(.success(poke))
                
                self.speciesUrl = poke.species.url
                
                self.getSpecies { result in
                    
                    switch result {
                    case .success(let poke):
                        self.evolutionChainUrl = poke.evolutionChain.url
                        
                    case .failure(let error):
                        print(error)
                    }
                }
                
            } catch {
                completed(.failure(.invalidData))
                print(error.self)
            }
        }
        task.resume()
    }
    
    
    func getSpecies(completed: @escaping (Result<EvolutionChainUrl, PokeError>) -> Void) {
        let endpoint = speciesUrl
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidName))
            return
        }
    
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let poke = try decoder.decode(EvolutionChainUrl.self, from: data)
                completed(.success(poke))
                
            } catch {
                completed(.failure(.invalidData))
                print(error.self)
            }
        }
        task.resume()
    }
}

