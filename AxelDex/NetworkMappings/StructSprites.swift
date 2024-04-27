//
//  StructSprites.swift
//  AxelDex
//
//  Created by Axel Iván Solano González on 26/04/24.
//

import Foundation

struct StructSprites: Codable {
    let back_default: String?
    let back_female: String?
    let back_shiny: String?
    let back_shiny_female: String?
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.back_default = try? values.decode(String.self, forKey: .back_default)
        self.back_female = try? values.decode(String.self, forKey: .back_female)
        self.back_shiny = try? values.decode(String.self, forKey: .back_shiny)
        self.back_shiny_female = try? values.decode(String.self, forKey: .back_shiny_female)
        self.front_default = try? values.decode(String.self, forKey: .front_default)
        self.front_female = try? values.decode(String.self, forKey: .front_female)
        self.front_shiny = try? values.decode(String.self, forKey: .front_shiny)
        self.front_shiny_female = try? values.decode(String.self, forKey: .front_shiny_female)
    }
}
