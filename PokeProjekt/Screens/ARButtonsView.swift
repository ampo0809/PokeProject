//
//  ARButtonsView.swift
//  PokeProjekt
//
//  Created by Nacho on 30.05.22.
//

import SwiftUI

struct ARButtonsView: View {
    var body: some View {
        
        Button {
            print("Eevee button was tapped")
        } label: {
            VStack {
                Image("eevee")
                    .resizable()
                Text("Eevee")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer().frame(height: 20)
            }
        }
        .frame(width: 150, height: 200, alignment: .center)
        .foregroundColor(.gray)
        .border(.blue, width: 1)
        .cornerRadius(2)
        
        Spacer().frame(height: 40)
        
        Button {
            print("Oddish button was tapped")
        } label: {
            VStack {
                Image("oddish")
                    .resizable()
                Text("Oddish")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer().frame(height: 20)
            }
        }
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
