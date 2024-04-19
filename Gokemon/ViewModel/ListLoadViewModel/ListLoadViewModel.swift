//
//  ListLoadViewModel.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import Foundation


protocol ListLoadDelegate: AnyObject {
    func onSuccessLoad()
    func onLoading()
    func finishLoading()
    func onError(error: Error)
}

protocol ListLoadViewModel {
    
    var delegate: ListLoadDelegate? { get set }
    
    var listData: [GokemonModel] { get set }
    
    func loadListGokemon(fistLoad: Bool)
    
    func changeOffset(offset: Int)
}
