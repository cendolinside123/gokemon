//
//  GokemonSpecies.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import Foundation

// MARK: - GokemonSpeciesModel
struct GokemonSpeciesModel: Codable {
    let id: Int
    let name: String
    let order, genderRate, captureRate, baseHappiness: Int
    let isBaby, isLegendary, isMythical: Bool
    let hatchCounter: Int
    let hasGenderDifferences, formsSwitchable: Bool
    let evolvesFromSpecies: PrevEvoModel?
    let evolutionChain: EvolutionChainModel?
    let flavorTextEntries: [FlavorTextEntryModel]
    let formDescriptions: [FormDescriptionModel]

    enum CodingKeys: String, CodingKey {
        case id, name, order
        case genderRate = "gender_rate"
        case captureRate = "capture_rate"
        case baseHappiness = "base_happiness"
        case isBaby = "is_baby"
        case isLegendary = "is_legendary"
        case isMythical = "is_mythical"
        case hatchCounter = "hatch_counter"
        case hasGenderDifferences = "has_gender_differences"
        case formsSwitchable = "forms_switchable"
        case evolvesFromSpecies = "evolves_from_species"
        case evolutionChain = "evolution_chain"
        case flavorTextEntries = "flavor_text_entries"
        case formDescriptions = "form_descriptions"
    }
}
