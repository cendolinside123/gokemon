//
//  ChainModel.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import Foundation

// MARK: - Chain
struct ChainModel: Codable {
    let isBaby: Bool
    let species: SpeciesModel
    let evolutionDetails: [EvolutionDetailModel]?
    let evolvesTo: [ChainModel]

    enum CodingKeys: String, CodingKey {
        case isBaby = "is_baby"
        case species
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
    }
}
