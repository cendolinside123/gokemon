//
//  GokemonModel.swift
//  Gokemon
//
//  Created by Jan Sebastian on 16/04/24.
//

import Foundation


struct GokemonModel: Codable, Hashable {
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
    
    static func == (lhs: GokemonModel, rhs: GokemonModel) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }

    func hash(into hasher: inout Hasher) {
        
    }
}

