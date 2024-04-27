//
//  TypeColorsList.swift
//  AxelDex
//
//  Created by Axel Iván Solano González on 26/04/24.
//

import UIKit
import SwiftUI

class TypeColorsList {
    struct ColorNumberType {
        let color:Color
        let id:Int
        
        init(color: UIColor, id: Int) {
            let finalColor = Color(color)
            self.color = finalColor
            self.id = id
        }
    }
    let dict: [String:ColorNumberType] = [
        "normal": ColorNumberType(color: UIColor(red: 168/255, green: 168/255, blue: 120/255, alpha: 1), id: 1),
        "fighting": ColorNumberType(color:UIColor(red: 192/255, green: 49/255, blue: 41/255, alpha: 1), id: 2),
        "flying": ColorNumberType(color: UIColor(red: 168/255, green: 144/255, blue: 240/255, alpha: 1), id: 3),
        "poison":  ColorNumberType(color: UIColor(red: 160/255, green: 64/255, blue: 160/255, alpha: 1),id: 4),
        "ground": ColorNumberType(color: UIColor(red: 224/255, green: 192/255, blue: 104/255, alpha: 1),id: 5),
        "rock": ColorNumberType(color: UIColor(red: 184/255, green: 160/255, blue: 55/255, alpha: 1),id: 6),
        "bug": ColorNumberType(color: UIColor(red: 168/255, green: 184/255, blue: 33/255, alpha: 1),id: 7),
        "ghost": ColorNumberType( color: UIColor(red: 112/255, green: 88/255, blue: 152/255, alpha: 1),id: 8),
        "steel": ColorNumberType( color: UIColor(red: 184/255, green: 184/255, blue: 208/255, alpha: 1),id: 9),
        "fire": ColorNumberType( color: UIColor(red: 240/255, green: 128/255, blue: 48/255, alpha: 1),id: 10),
        "water": ColorNumberType(color: UIColor(red: 105/255, green: 144/255, blue: 240/255, alpha: 1),id: 11),
        "grass": ColorNumberType(color: UIColor(red: 120/255, green: 200/255, blue: 80/255, alpha: 1),id: 12),
        "electric": ColorNumberType(color: UIColor(red: 248/255, green: 208/255, blue: 48/255, alpha: 1),id: 13),
        "psychic": ColorNumberType(color: UIColor(red: 245/255, green: 88/255, blue: 136/255, alpha: 1),id: 14),
        "ice": ColorNumberType(color: UIColor(red: 152/255, green: 216/255, blue: 216/255, alpha: 1),id: 15),
        "dragon": ColorNumberType(color: UIColor(red: 112/255, green: 56/255, blue: 248/255, alpha: 1),id: 16),
        "dark": ColorNumberType(color: UIColor(red: 112/255, green: 88/255, blue: 71/255, alpha: 1),id: 17),
        "fairy": ColorNumberType(color: UIColor(red: 238/255, green: 153/255, blue: 172/255, alpha: 1),id: 18)
    ]
}
