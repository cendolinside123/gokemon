//
//  GokemonDetailViewModel.swift
//  Gokemon
//
//  Created by Jan Sebastian on 18/04/24.
//

import Foundation
import RxSwift


protocol GokemonDetailDelegate: AnyObject {
    func onEndLoad()
    func onLoading()
    func onSuccess()
    func onError(error: Error)
}

protocol GokemonDetailViewModel {
    var gokeminInformation: [GokemonInfoModel] { get set }
    var delegate: GokemonDetailDelegate? { get set }
    func loadGokemonDetail(url: String, name: String)
}
