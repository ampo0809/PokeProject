//
//  View+Ext.swift
//  PokeProjekt
//
//  Created by Nacho on 27.04.22.
//

import SwiftUI

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
