//
//  EvolutionDetailModel.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import Foundation

// MARK: - EvolutionDetail
struct EvolutionDetailModel: Codable {
    let item: ItemEvoModel?
    let trigger: SpeciesModel
    let minLevel: Int?
    let needsOverworldRain: Bool?
    let timeOfDay: String?
    let turnUpsideDown: Bool?

    enum CodingKeys: String, CodingKey {
        case item, trigger
        case minLevel = "min_level"
        case needsOverworldRain = "needs_overworld_rain"
        case timeOfDay = "time_of_day"
        case turnUpsideDown = "turn_upside_down"
    }
}



