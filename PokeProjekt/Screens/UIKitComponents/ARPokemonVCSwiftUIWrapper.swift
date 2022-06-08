//
//  ARPokemonVCSwiftUIWrapper.swift
//  PokeProjekt
//
//  Created by Nacho on 08.06.22.
//

import SwiftUI
import UIKit

struct ARPokemonVCSwiftUIWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        return ARPokemonVC()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
