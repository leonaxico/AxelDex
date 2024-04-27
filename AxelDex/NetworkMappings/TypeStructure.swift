//
//  TypeStructure.swift
//  AxelDex
//
//  Created by Axel Iván Solano González on 26/04/24.
//

import Foundation

struct TypeStructure: Codable {
    let name:String
    let url:String
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.url = try values.decode(String.self, forKey: .url)
    }
}

struct OnPokemonType: Codable {
    let slot:Int
    let type: TypeStructure
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.slot = try values.decode(Int.self, forKey: .slot)
        self.type = try values.decode(TypeStructure.self, forKey: .type)
    }
}
