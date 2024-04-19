//
//  GokemonLocal+extensions.swift
//  Gokemon
//
//  Created by Jan Sebastian on 16/04/24.
//

import Foundation
import CoreData

extension GokemonLocal {
    func toOnlinemodel() -> GokemonModel? {
        if let name, 
            let url {
            return GokemonModel(name: name, url: url)
        }
        return nil
    }
    
    func toCustomOnlineMod() -> (GokemonModel, GokemonDetailModel, GokemonEvoChainModel?)? {
        
        guard let name else {
            return nil
        }
        
        guard let url else {
            return nil
        }
        
        var getChainEvoModel: GokemonEvoChainModel?
        
        if let getChainEvo = self.chainEvo {
            getChainEvoModel = getChainEvo.toOnlineModel()
            
        } else {
            getChainEvoModel = nil
        }
        guard let detailGokemon = self.detail?.toOnlinemodel() else {
            return nil
        }
        
        return (GokemonModel(name: name, url: url), detailGokemon, getChainEvoModel)
    }
    
}
