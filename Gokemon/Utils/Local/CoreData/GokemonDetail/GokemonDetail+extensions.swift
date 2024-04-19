//
//  GokemonDetail+extensions.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import Foundation
import CoreData

extension GokemonDetail {
    func toOnlinemodel() -> GokemonDetailModel? {
        
        var getAbilities: [AbilityModel] = []
        let getBaseExperience = Int(self.baseExperience)
        var getCries: CriesModel?
        let getHeight: Double? = self.height?.doubleValue
        let getWidth: Double? = self.weight?.doubleValue
        var getHeldItem: [ItemModel] = []
        let getID = Int(self.id)
        let getLocationAreaEncounters: String? = self.locationAreaEncounters
        let getOrder = Int(self.order)
        var getPastType: [PastTypeModel] = []
        var getSpeciesModel: SpeciesModel?
        var getSpritesModel: SpritesModel?
        var getStatsModel: [StatModel] = []
        var getTypeElementModel: [TypeElementModel] = []
        
        
        if let abilities {
            let tryGetAbilities = try? JSONDecoder().decode([AbilityModel].self, from: abilities)
            
            if let tryGetAbilities {
                getAbilities = tryGetAbilities
            } else {
                return nil
            }
            
        } else {
            getAbilities = []
        }
        
        if let heldItems {
            let tryGetHeldItem = try? JSONDecoder().decode([ItemModel].self, from: heldItems)
            
            if let tryGetHeldItem {
                getHeldItem = tryGetHeldItem
            } else {
                return nil
            }
            
        } else {
            getHeldItem = []
        }
        
        if let cries {
            getCries = try? JSONDecoder().decode(CriesModel.self, from: cries)
        } else {
            return nil
        }
        
        if let pastTypes {
            let tryGetPastType = try? JSONDecoder().decode([PastTypeModel].self, from: pastTypes)
            
            guard let tryGetPastType else {
                return nil
            }
            getPastType = tryGetPastType
        } else {
            getPastType = []
        }
        
        if let stats {
            let tryGetStats  = try? JSONDecoder().decode([StatModel].self, from: stats)
            
            if let tryGetStats {
                getStatsModel = tryGetStats
            } else {
                return nil
            }
            
        } else {
            getStatsModel = []
        }
        
        if let types {
            let tryGetTypes = try? JSONDecoder().decode([TypeElementModel].self, from: types)
            
            if let tryGetTypes {
                getTypeElementModel = tryGetTypes
            } else {
                return nil
            }
            
        } else {
            getTypeElementModel = []
        }
        
        guard let species else {
            return nil
        }
        
        getSpeciesModel = try? JSONDecoder().decode(SpeciesModel.self, from: species)
        
        guard let sprites else {
            return nil
        }
        
        getSpritesModel = try? JSONDecoder().decode(SpritesModel.self, from: sprites)
        
        guard let getCries else {
            return nil
        }
        
        guard let getHeight else {
            return nil
        }
        
        guard let getWidth else {
            return nil
        }
        
        guard let getLocationAreaEncounters else {
            return nil
        }
        
        guard let name else {
            return nil
        }
        
        guard let getSpeciesModel else {
            return nil
        }
        
        guard let getSpritesModel else {
            return nil
        }
        
        
        return GokemonDetailModel(abilities: getAbilities, baseExperience: getBaseExperience, cries: getCries, height: getHeight, heldItems: getHeldItem, id: getID, isDefault: self.isDefault, locationAreaEncounters: getLocationAreaEncounters, name: name, order: getOrder, pastTypes: getPastType, species: getSpeciesModel, sprites: getSpritesModel, stats: getStatsModel, types: getTypeElementModel, weight: getWidth)
        
    }
}
