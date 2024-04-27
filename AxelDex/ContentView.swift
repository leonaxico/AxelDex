//
//  ContentView.swift
//  AxelDex
//
//  Created by Axel Iván Solano González on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var pokemons = [Pokemon]()
    @State private var previous = ""
    @State private var next = ""
    @State private var searchText = ""
    @State private var showingTypes = false
    var originType: String?
    
    var body: some View {
        if let originType = originType {
            Text(originType.uppercased())
                .font(.title)
                .background(TypeColorsList().dict[originType]?.color)
                .cornerRadius(5)
        }
        NavigationView{
            VStack{
                List(searchResults, id: \.pokemonNumber){
                    pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemonNumber: pokemon.pokemonNumber)) {
                        HStack {
                            AsyncImage(url: URL(string: pokemon.spriteURL)) {
                                image in
                                image.image?.resizable()
                            }
                            .frame(width: 70, height: 70)
                            Text(pokemon.name).bold()
                            Spacer()
                            Text(String(pokemon.pokemonNumber))
                        }
                    }
                }.task {
                    await loadData()
                }
                HStack {
                    Button("Previous"){
                        Task {
                            await loadData(from: previous)
                        }
                    }.buttonStyle(.bordered)
                    .disabled(previous.isEmpty)
                    Button("Filter by Type"){
                        showingTypes.toggle()
                    }.sheet(isPresented: $showingTypes, content: {
                        let types = TypeColorsList().dict.sorted(by: {$0.key < $1.key})
                        ForEach(types, id: \.key) { key, value in
                            Button(key){
                                Task {
                                    await searchByType(typeId: value.id)
                                }
                                showingTypes = false
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(value.color)
                            .cornerRadius(10)
                        }
                    })
                    .buttonStyle(.bordered)
                    Button("Next"){
                        Task {
                           await loadData(from: next)
                        }
                    }.buttonStyle(.bordered)
                    .disabled(next.isEmpty)
                }
            }
            .navigationTitle("AxelDex:")
        }.searchable(text: $searchText, prompt: "Find by name or id")
            .onSubmit(of: .search) {
                Task {
                    await searchByNameOrID()
                }
            }
    }
    
    var searchResults: [Pokemon] {
        if searchText.isEmpty {
            if pokemons.count < 2 {
                Task {
                    await loadData()
                }
            }
            return pokemons
        } else {
            return pokemons.filter { pokemon in
                pokemon.name.contains(searchText.lowercased()) || String(pokemon.pokemonNumber).contains(searchText)
            }
        }
    }
    
    func searchByNameOrID() async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(searchText.lowercased())") else {
            print("invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let pokemonDetails = try? JSONDecoder().decode(PokemonDetailStruct.self, from: data){
                print(pokemonDetails.name)
                pokemons = [Pokemon(name: pokemonDetails.name, pokemonNumber: pokemonDetails.id, url: url.absoluteString)]
            }
        } catch {
            print("Pokemon not found")
        }
        
    }
    
    func loadData(from urlString:String = "https://pokeapi.co/api/v2/pokemon") async {
        if let originType = originType {
            await searchByType(typeName: originType)
            return
        }
        guard let url = URL(string: urlString)  else {
            print("invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let speciesResponse = try? JSONDecoder().decode(SpeciesResponse.self, from: data) {
                pokemons = speciesResponse.results
                previous = speciesResponse.previous ?? ""
                next = speciesResponse.next ?? ""
            }
        } catch {
            print("Invalid data")
        }
    }
    
    func searchByType( typeId: Int) async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/type/\(typeId)") else {
            print("invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let pokemonDetails = try? JSONDecoder().decode(TypeFilterResponse.self, from: data){
                var typePokemons:[Pokemon] = []
                pokemonDetails.pokemon.forEach { pokemon in
                    typePokemons.append(pokemon.pokemon)
                }
                pokemons = typePokemons
            }
        } catch {
            print("Pokemon not found")
        }
    }
    
    func searchByType( typeName: String) async  {
        let typeId:Int = TypeColorsList().dict[typeName]?.id ?? 1
        await searchByType(typeId: typeId)
    }
}

#Preview {
    ContentView()
}

