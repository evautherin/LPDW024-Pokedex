//
//  ContentView.swift
//  Pokedex
//
//  Created by Etienne Vautherin on 08/02/2024.
//

import SwiftUI

struct ContentView: View {
    let model = ApiModel.shared
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
