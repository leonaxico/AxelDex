//
//  StatStructure.swift
//  AxelDex
//
//  Created by Axel Iván Solano González on 26/04/24.
//

import Foundation

struct StatStructure: Codable {
    let base_stat:Int
    let effort: Int
    let stat: Stat
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.base_stat = try values.decode(Int.self, forKey: .base_stat)
        self.effort = try values.decode(Int.self, forKey: .effort)
        self.stat = try values.decode(Stat.self, forKey: .stat)
    }
}

struct Stat: Codable {
    let name:String
    let url:String
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.url = try values.decode(String.self, forKey: .url)
    }
}
