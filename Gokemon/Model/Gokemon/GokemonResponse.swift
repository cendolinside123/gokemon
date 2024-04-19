//
//  GokemonResponse.swift
//  Gokemon
//
//  Created by Jan Sebastian on 16/04/24.
//

import Foundation

// MARK: - GokemonResponse
struct GokemonResponse: Codable {
    let count: Int
    let next, previous: String?
    let results: [GokemonModel]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }
}
