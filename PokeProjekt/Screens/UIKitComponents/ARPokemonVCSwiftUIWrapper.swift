//
//  ARPokemonVCSwiftUIWrapper.swift
//  PokeProjekt
//
//  Created by Nacho on 08.06.22.
//

import SwiftUI
import UIKit

struct ARPokemonVCSwiftUIWrapper: UIViewControllerRepresentable {
    
    @Binding var selectedPokemon: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        let arPokemonVC = ARPokemonVC()
        arPokemonVC.pokemonName = selectedPokemon
        
        return arPokemonVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
