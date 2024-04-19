//
//  GokemonDetailModel.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import Foundation

// MARK: - GokemonDetailModel
struct GokemonDetailModel: Codable {
    let abilities: [AbilityModel]
    let baseExperience: Int
    let cries: CriesModel
    let height: Double
    let heldItems: [ItemModel]
    let id: Int
    let isDefault: Bool
    let locationAreaEncounters: String
    let name: String
    let order: Int
    let pastTypes: [PastTypeModel]
    let species: SpeciesModel
    let sprites: SpritesModel
    let stats: [StatModel]
    let types: [TypeElementModel]
    let weight: Double

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case cries
        case height
        case heldItems = "held_items"
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case name, order
        case pastTypes = "past_types"
        case species, sprites, stats, types, weight
    }
}

struct PastTypeModel: Codable {
    let generation: GenerationModel
    let types: [TypeModel]
}

struct TypeModel: Codable {
    let name: String?
    let url: String?
    let type: typeInfoModel?
}

struct typeInfoModel: Codable {
    let name: String
    let url: String
}

struct GenerationModel: Codable {
    let name: String
    let url: String
}


// MARK: - Ability
struct AbilityModel: Codable {
    let ability: AbilityInfoModel
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct AbilityInfoModel: Codable {
    let name: String
    let url: String
}

// MARK: - Species
struct SpeciesModel: Codable {
    let name: String
    let url: String
}

struct ItemModel: Codable {
    let item: ItemModeInfo
}

struct ItemModeInfo: Codable {
    let name: String
    let url: String
}

// MARK: - Cries
struct CriesModel: Codable {
    let latest, legacy: String
}

// MARK: - Sprites
class SpritesModel: Codable {
    let backDefault: String
    let backFemale: String?
    let backShiny: String
    let backShinyFemale: String?
    let frontDefault: String
    let frontFemale: String?
    let frontShiny: String
    let frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

// MARK: - Stat
struct StatModel: Codable {
    let baseStat, effort: Int
    let stat: StatInfoModel

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

struct StatInfoModel: Codable {
    let name: String
    let url: String
}

// MARK: - TypeElement
struct TypeElementModel: Codable {
    let slot: Int
    let type: TypeModel
}
