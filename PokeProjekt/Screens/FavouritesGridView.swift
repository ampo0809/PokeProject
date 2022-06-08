//
//  FavouritesGridView.swift
//  PokeProjekt
//
//  Created by Nacho on 31.05.22.
//

import SwiftUI

struct FavouritesGridView: View {
    
    @ObservedObject private var fdc = FavouritesDataController()
    @State private var unknown = "unknown"
    
    let layout = [GridItem(.adaptive(minimum: 100))]

    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: layout, spacing: 10) {
           
                ForEach(fdc.favouritesData, id: \.self) { item in
                    ReusableBox(name: item.generalSpecs.first?.name ?? unknown, fdc: fdc)
                }
            }
            .padding(.horizontal)
        }
//        .task { getFavouritesFromLocalData() }
    }
}

struct ReusableBox: View {
    
    var name: String
    @State private var showingSheet: Bool = false
    @State private var isLongPressed: Bool = false
    
    @State var fdc: FavouritesDataController
//    @ObservedObject private var fdc = FavouritesDataController()
    
    var body: some View {
        VStack {

            Button {
                showingSheet.toggle()
            } label: {
                VStack {
                    Image(name)
                        .resizable()
                        .frame(width: 90, height: 90)
                        .background(Color.init(uiColor: .systemGray5))
                        .cornerRadius(12)
                    Text(name.capitalized)
                        .font(.subheadline)
                        .foregroundColor(Color.init(uiColor: .systemGray))
                        .fontWeight(.bold)
                }
            }
            .sheet(isPresented: $showingSheet, onDismiss: {
                print("Sheet dismissed")
                getFavouritesFromLocalData()
                
            }, content: {
                NavigationView {
                    VStack {
                        SpecsView(selectedPokemon: name, isPerformingNetworkCall: .constant(false))
                    }
                }
                            
                .navigationTitle(name)
                .navigationBarTitleDisplayMode(.inline)
            })
        }
    }
}

extension ReusableBox {
    
    func getFavouritesFromLocalData() {
        PersistanceManager.retrievePokemons { result in
            switch result {
            case .success(let favo):
                fdc.favouritesData = favo

            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}
