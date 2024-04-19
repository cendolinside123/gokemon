//
//  GokemonLocalUseCase.swift
//  Gokemon
//
//  Created by Jan Sebastian on 16/04/24.
//

import Foundation
import CoreData
import RxSwift

protocol GokemonLocalUseCase {
    func fetchData(limit: Int, offset: Int) -> Single<[GokemonLocal]>
    func fetchData() -> Single<[GokemonLocal]>
    func inputData(name: String, url: String) -> Completable
    func getItem(name: String) -> Single<GokemonLocal?>
    func getItem(url: String) -> Single<GokemonLocal?>
    func inputDetail(gokemon: GokemonLocal,
                     detail: GokemonDetailModel,
                     evo: GokemonEvoChainModel?) -> Completable
}
