//
//  ContentView.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var pdc = PokeDataController()
    @State var viewIndex: Int = 0
    
    var body: some View {
        
        ListView(pokeData: pdc.pokeData, viewIndex: $viewIndex)

            .onAppear {}
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

