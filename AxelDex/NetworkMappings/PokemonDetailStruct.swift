//
//  PokemonDetailStruct.swift
//  AxelDex
//
//  Created by Axel Iván Solano González on 26/04/24.
//

import Foundation

struct PokemonDetailStruct: Codable {
    let id: Int
    let name: String
    let sprites: StructSprites
    let stats: [StatStructure]
    let types: [OnPokemonType]
    
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.sprites = try values.decode(StructSprites.self, forKey: .sprites)
        self.stats = try values.decode([StatStructure].self, forKey: .stats)
        self.types = try values.decode([OnPokemonType].self, forKey: .types)
    }
}
