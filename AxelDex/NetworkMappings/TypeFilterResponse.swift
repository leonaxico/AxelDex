//
//  TypeFilterResponse.swift
//  AxelDex
//
//  Created by Axel Iván Solano González on 26/04/24.
//

import Foundation

struct TypeFilterResponse: Codable {
    let pokemon: [PokemonTypeFilter]
}

struct PokemonTypeFilter: Codable {
    let pokemon:Pokemon
    let slot:Int
}
