//
//  ContentView.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var pdc = PokeDataController()
    @State private var viewIndex: Int = 0
    @State private var navigationTitle: String = "Pokédex"
    
    var body: some View {

        NavigationView {
            VStack() {
                if viewIndex == 0 { ListView(pokeData: pdc.pokeData) }
                if viewIndex == 2 { ARButtonsView() }
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    Spacer()
                    Button("\(Image(systemName: "sparkle.magnifyingglass"))", role: .destructive) {
                        viewIndex = 0
                        navigationTitle = "Pokédex"
                    }
                    
                    Spacer()
                    Button("\(Image(systemName: "star.circle"))", role: .destructive) {
                        print("Favourites presseed")
                    }
                    
                    Spacer()
                    Button("\(Image(systemName: "rotate.3d"))", role: .destructive) {
                        viewIndex = 2
                        navigationTitle = "3D Pokémons"
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        //Not sure what this does, but silences an annoying error: https://stackoverflow.com/questions/65316497/
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

