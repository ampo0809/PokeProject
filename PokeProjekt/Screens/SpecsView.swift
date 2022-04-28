//
//  SpecsView.swift
//  PokeProjekt
//
//  Created by Nacho on 28.04.22.
//

import SwiftUI

struct SpecsView: View {
    
    let names = NamesArray()
    
    var body: some View {
        
        VStack {
            Text("Pikachu")
                .font(.title2)
                .bold()
            
            Image("pikachu")
                .resizable()
            //                .frame(width: 200, height: 200).background(Color.blue)
            //                .mask {
            //                    Rectangle()
            //                        .frame(width: 100, height: 100)
            //                }
            
            
            //                .frame(width: 100, height: 100, alignment: .center)
            //                .clipped()
            //                .border(Color.black)
            //
            
            List {
                Section() {
                    ForEach((1...3), id: \.self) { Text("\($0)…") }
                } header: { Text("Basics") }
                
                Section() {
                    ForEach((1...3), id: \.self) { Text("\($0)…") }
                } header: { Text("Abilities") }
                
                Section() {
                    ForEach((1...10), id: \.self) { Text("\($0)…") }
                } header: { Text("Evolution Chain") }
                
                
            }
        }
    }
}

struct SpecsView_Previews: PreviewProvider {
    static var previews: some View {
        SpecsView()
    }
}
