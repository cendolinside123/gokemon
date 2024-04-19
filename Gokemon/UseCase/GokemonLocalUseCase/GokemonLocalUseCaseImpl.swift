//
//  GokemonLocalUseCaseImpl.swift
//  Gokemon
//
//  Created by Jan Sebastian on 16/04/24.
//

import Foundation
import CoreData
import RxSwift

struct GokemonLocalUseCaseImpl {
    
}

extension GokemonLocalUseCaseImpl: GokemonLocalUseCase {
    func fetchData(limit: Int, offset: Int) -> RxSwift.Single<[GokemonLocal]> {
        return Single.create(subscribe: { emmiter in
            
            CoreDataStack.shared.doInBackground {
                let fetchData = GokemonLocal.fetchRequest()
                fetchData.fetchLimit = limit
                fetchData.fetchOffset = offset
                
                do {
                    let doFetch = try CoreDataStack.shared.getPrivateContext().fetch(fetchData)
                    emmiter(.success(doFetch))
                } catch let error as NSError {
                    emmiter(.failure(error))
                }
            }
            
            return Disposables.create()
        })
    }
    
    func fetchData() -> Single<[GokemonLocal]> {
        return Single.create(subscribe: { emmiter in
            
            CoreDataStack.shared.doInBackground {
                let fetchData = GokemonLocal.fetchRequest()
                
                do {
                    let doFetch = try CoreDataStack.shared.getPrivateContext().fetch(fetchData)
                    emmiter(.success(doFetch))
                } catch let error as NSError {
                    emmiter(.failure(error))
                }
            }
            
            return Disposables.create()
        })
    }
    
    func inputData(name: String, url: String) -> RxSwift.Completable {
        return Completable.create(subscribe: { emmiter in
            
            CoreDataStack.shared.doInBackground {
                do {
                    let context = CoreDataStack.shared.getPrivateContext()
                    let gokemonLocal = GokemonLocal(context: context)
                    gokemonLocal.name = name
                    gokemonLocal.url = url
                    
                    try context.save()
                    emmiter(.completed)
                } catch let error as NSError {
                    emmiter(.error(error))
                }
                
            }
            
            return Disposables.create()
        })
    }
    
    func inputDetail(gokemon: GokemonLocal,
                     detail: GokemonDetailModel,
                     evo: GokemonEvoChainModel?) -> RxSwift.Completable {
        return Completable.create(subscribe: { emmiter in
            
            CoreDataStack.shared.doInBackground {
                do {
                    let context = CoreDataStack.shared.getPrivateContext()
                    
                    let inputDetail = GokemonDetail(context: context)
                    
                    if detail.abilities.count > 0 {
                        if let doEncodeAbility = try? JSONEncoder().encode(detail.abilities) {
                            inputDetail.abilities = doEncodeAbility
                        } else {
                            throw ErrorResponse.CustomError("failed input abilities")
                        }
                    }
                    
                    inputDetail.baseExperience = Int64(detail.baseExperience)
                    
                    if let doEncodeCries = try? JSONEncoder().encode(detail.cries) {
                        inputDetail.cries = doEncodeCries
                    } else {
                        throw ErrorResponse.CustomError("failed input cries")
                    }
                    
                    inputDetail.height = NSDecimalNumber(value: detail.height)
                    
                    if detail.heldItems.count > 0 {
                        if let doEncodeHeldItem = try? JSONEncoder().encode(detail.heldItems) {
                            inputDetail.heldItems = doEncodeHeldItem
                        } else {
                            throw ErrorResponse.CustomError("failed input held item")
                        }
                    }
                    inputDetail.id = Int64(detail.id)
                    inputDetail.isDefault = detail.isDefault
                    inputDetail.locationAreaEncounters = detail.locationAreaEncounters
                    inputDetail.name = detail.name
                    inputDetail.order = Int64(detail.order)
                    
                    if detail.pastTypes.count > 0 {
                        if let doEncodePastType = try? JSONEncoder().encode(detail.pastTypes) {
                            inputDetail.pastTypes = doEncodePastType
                        } else {
                            throw ErrorResponse.CustomError("failed input past type")
                        }
                    }
                    
                    if let doEncodeSpecies = try? JSONEncoder().encode(detail.species) {
                        inputDetail.species = doEncodeSpecies
                    } else {
                        throw ErrorResponse.CustomError("failed input species")
                    }
                    
                    if let doinputSprites = try? JSONEncoder().encode(detail.sprites) {
                        inputDetail.sprites = doinputSprites
                    } else {
                        throw ErrorResponse.CustomError("failed input sprites")
                    }
                    
                    if detail.stats.count > 0 {
                        if let doEncodeStats = try? JSONEncoder().encode(detail.stats) {
                            inputDetail.stats = doEncodeStats
                        } else {
                            throw ErrorResponse.CustomError("failed input stats")
                        }
                    }
                    
                    if detail.types.count > 0 {
                        if let doEncodeTypeElemnt = try? JSONEncoder().encode(detail.types) {
                            inputDetail.types = doEncodeTypeElemnt
                        } else {
                            throw ErrorResponse.CustomError("failed input type of elements")
                        }
                    }
                    
                    inputDetail.weight = NSDecimalNumber(value: detail.weight)
                    gokemon.detail = inputDetail
                    inputDetail.gokemon = gokemon
                    
                    if let evo {
                        let inputChain = GokemonChainEvo(context: context)
                        inputChain.id = Int64(evo.id)
                        if let getChain = evo.chain {
                            if let doInputChain = try? JSONEncoder().encode(getChain) {
                                inputChain.chain = doInputChain
                            } else {
                                throw ErrorResponse.CustomError("failed input chain evo")
                            }
                        } else {
                            throw ErrorResponse.CustomError("failed input chain evo")
                        }
                        
                        inputChain.gokemon = gokemon
                        gokemon.chainEvo = inputChain
                    }
                    
                    
                    try context.save()
                    emmiter(.completed)
                } catch let error as NSError {
                    emmiter(.error(error))
                }
            }
            
            return Disposables.create()
        })
    }
    
    func getItem(name: String) -> RxSwift.Single<GokemonLocal?> {
        return Single.create(subscribe: { emmiter in
            
            CoreDataStack.shared.doInBackground {
                let fetchData = GokemonLocal.fetchRequest()
                fetchData.predicate = NSPredicate(format: "%K == '\(name)'", (\GokemonLocal.name)._kvcKeyPathString!)
                
                do {
                    let doFetch = try CoreDataStack.shared.getPrivateContext().fetch(fetchData)
                    emmiter(.success(doFetch.first))
                } catch let error as NSError {
                    emmiter(.failure(error))
                }
            }
            
            return Disposables.create()
        })
    }
    
    func getItem(url: String) -> RxSwift.Single<GokemonLocal?> {
        return Single.create(subscribe: { emmiter in
            
            CoreDataStack.shared.doInBackground {
                let fetchData = GokemonLocal.fetchRequest()
                fetchData.predicate = NSPredicate(format: "%K == '\(url)'", (\GokemonLocal.url)._kvcKeyPathString!)
                
                do {
                    let doFetch = try CoreDataStack.shared.getPrivateContext().fetch(fetchData)
                    emmiter(.success(doFetch.first))
                } catch let error as NSError {
                    emmiter(.failure(error))
                }
            }
            
            return Disposables.create()
        })
    }
}

