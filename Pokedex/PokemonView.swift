//
//  PokemonView.swift
//  Pokedex
//
//  Created by Etienne Vautherin on 08/02/2024.
//

import SwiftUI

struct PokemonView: View {
    let urlString: String
    
    @State var pokemon: Pokemon?
    
    var imageUrl: URL? {
        guard let pokemon else { return .none }
        return URL(string: pokemon.sprites.front_default)
    }
    
    var body: some View {
        VStack {            
            if let pokemon {
                if let imageUrl {
                    AsyncImage(url: imageUrl)
                        .frame(width: 200, height: 200)
                }
                Text(pokemon.name)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                guard let url = URL(string: urlString) else {
                    print("Error with URL")
                    return
                }
                
                let (data, response) = try await URLSession.shared.data(from: url)
                
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    print("Error with request")
                    return
                }
                
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    self.pokemon = pokemon
               } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
}

#Preview {
    PokemonView(urlString: "https://pokeapi.co/api/v2/pokemon/1/")
}
