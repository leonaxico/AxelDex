//
//  PokemonDetailView.swift
//  AxelDex
//
//  Created by Axel Iván Solano González on 26/04/24.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemonNumber: Int = 1
    @State private var pokemon: PokemonDetailStruct?
    var body: some View {
        VStack{
            Text(pokemon?.name.capitalized ?? "absol".capitalized)
            HStack{
                if let spriteDefault = pokemon?.sprites.front_default {
                    AsyncImage(url: URL(string: spriteDefault ))
                }
                if let spriteShiny = pokemon?.sprites.front_shiny {
                    AsyncImage(url: URL(string: spriteShiny))
                }
            }
            HStack{
                Text("Types:")
                if let firstTypeName = pokemon?.types.first?.type.name {
                    NavigationLink(firstTypeName, destination: ContentView(originType: firstTypeName))
                        .buttonStyle(.borderedProminent)
                        .tint(TypeColorsList().dict[firstTypeName]?.color)
                        .cornerRadius(10)
                        .navigationTitle(pokemon?.name.capitalized ?? "Pokemon detail")
                    if let secondTypeName = pokemon?.types.last?.type.name, secondTypeName != firstTypeName {
                        NavigationLink(secondTypeName, destination: ContentView(originType: secondTypeName))
                            .buttonStyle(.borderedProminent)
                            .tint(TypeColorsList().dict[secondTypeName]?.color)
                            .cornerRadius(10)
                            .navigationTitle(pokemon?.name.capitalized ?? "Pokemon detail")
                    }
                }
                
                
            }
            Text("Stats:")
                .font(.title)
                .tint(.red)
            if let stats = pokemon?.stats {
                List(stats, id: \.stat.name) {
                    stat in 
                    Text("\(stat.stat.name):  \(stat.base_stat)")
                }
            }
        }.task {
            await loadPokemonInfo()
        }
    }
    
    func loadPokemonInfo() async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonNumber)") else {
            print("invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let pokemonDetails = try? JSONDecoder().decode(PokemonDetailStruct.self, from: data){
                pokemon = pokemonDetails
            }
        } catch {
            print("Pokemon not found")
        }
        
    }
}
