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
        NavigationSplitView {
            List {
                ForEach(model.pokemonLinks, id: \.url) { link in
                    NavigationLink {
                        PokemonView(urlString: link.url)
                    } label: {
                        Text(link.name)
                    }
                }
            }
            .navigationTitle(Text("Pokedex"))
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView()
}
