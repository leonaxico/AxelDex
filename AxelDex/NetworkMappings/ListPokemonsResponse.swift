//
//  ListPokemonsResponse.swift
//  AxelDex
//
//  Created by Axel Iván Solano González on 26/04/24.
//

import Foundation

struct SpeciesResponse: Codable {
    let count: Int
    let next:String?
    let previous:String?
    let results:[Pokemon]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decode(Int.self, forKey: .count)
        results = try values.decode([Pokemon].self, forKey: .results)
        next = try? values.decode( String.self, forKey: .next)
        previous = try? values.decode( String.self, forKey: .previous)
    }
}

struct Pokemon: Codable {
    let name:String
    let pokemonNumber:Int
    let url:String
    let spriteURL:String
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        url = try values.decode(String.self, forKey: .url)
        var urlComponents = url.components(separatedBy: "/")
        urlComponents = urlComponents.dropLast()
        pokemonNumber = Int (urlComponents.last ?? "0") ?? 0
        spriteURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonNumber).png"
    }
    
    init(name: String, pokemonNumber: Int, url:String){
        self.name = name
        self.pokemonNumber = pokemonNumber
        self.url = url
        self.spriteURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonNumber).png"
    }
}
