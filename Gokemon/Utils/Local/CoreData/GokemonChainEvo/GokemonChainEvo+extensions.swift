//
//  GokemonChainEvo+extensions.swift
//  Gokemon
//
//  Created by Jan Sebastian on 18/04/24.
//

import Foundation
import CoreData

extension GokemonChainEvo {
    func toOnlineModel() -> GokemonEvoChainModel? {
        let id = Int(self.id)
        var chainData: ChainModel?
        if let chain {
            chainData = try? JSONDecoder().decode(ChainModel.self, from: chain)
        } else {
            return nil
        }
        
        if let chainData {
            return GokemonEvoChainModel(id: id, chain: chainData)
        }
        
        return nil
    }
}
