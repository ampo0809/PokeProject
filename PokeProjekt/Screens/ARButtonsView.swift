//
//  ARButtonsView.swift
//  PokeProjekt
//
//  Created by Nacho on 30.05.22.
//

import SwiftUI

struct ARButtonsView: View {

    var body: some View {
        
        ARButton(pokemonName: .constant("eevee"))
        
        Spacer().frame(height: 40)
            
        ARButton(pokemonName: .constant("oddish"))
    }
}

struct ARButton: View {
    
    @State private var isPresented = false
    @State private var selectedPokemon = String()
    
    @Binding var pokemonName: String
    
    var body: some View {
        
        Button {
            print("\(pokemonName) button was tapped")
            selectedPokemon = pokemonName
            self.isPresented.toggle()
            
        } label: {
            VStack {
                Image(pokemonName)
                    .resizable()
                Text(pokemonName.capitalized)
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer().frame(height: 20)
            }
        }
        
        .sheet(isPresented: $isPresented, content: {
            
//            NavigationView {
                ARPokemonVCSwiftUIWrapper(selectedPokemon: $selectedPokemon)
//            }
//            .navigationTitle(pokemonName.capitalized)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                <#code#>
//            }
            
        })
        .frame(width: 150, height: 200, alignment: .center)
        .foregroundColor(.gray)
        .border(.blue, width: 1)
        .cornerRadius(2)
    }
}

struct ARButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ARButtonsView()
    }
}
