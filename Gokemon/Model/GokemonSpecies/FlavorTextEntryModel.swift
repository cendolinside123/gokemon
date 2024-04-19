//
//  FlavorTextEntryModel.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import Foundation

// MARK: - FlavorTextEntry
struct FlavorTextEntryModel: Codable {
    let flavorText: String

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
    }
}
