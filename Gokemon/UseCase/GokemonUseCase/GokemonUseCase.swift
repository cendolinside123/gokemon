//
//  GokemonUseCase.swift
//  Gokemon
//
//  Created by Jan Sebastian on 16/04/24.
//

import Foundation
import RxSwift

protocol GokemonUseCase {
    func fetchListGokemom(offset: Int, limit: Int) -> Single<GokemonResponse>
    func fetchGokemonDetail(url: String) -> Single<GokemonDetailModel>
    func fetchGokemonChainEvo(url: String) -> Single<GokemonEvoChainModel>
    func fetchGokemonSpecies(url: String) -> Single<GokemonSpeciesModel>
}
