//
//  GokemonInfoModel.swift
//  Gokemon
//
//  Created by Jan Sebastian on 18/04/24.
//

import Foundation


enum InfoType {
    case MainInfo
    case StatsInfo
    case EvoInfo
}

struct GokemonInfoModel {
    let typeInfo: InfoType
    let detail: GokemonDetailModel?
    let evo: GokemonEvoChainModel?
}
