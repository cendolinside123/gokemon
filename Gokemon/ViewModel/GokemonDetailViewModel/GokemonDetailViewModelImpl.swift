//
//  GokemonDetailViewModelImpl.swift
//  Gokemon
//
//  Created by Jan Sebastian on 18/04/24.
//

import Foundation
import CoreData
import RxSwift


class GokemonDetailViewModelImpl {
    var gokeminInformation: [GokemonInfoModel] = []
    weak var delegate: GokemonDetailDelegate?
    
    private var disposableBag = DisposeBag()
    @Service private var usecaseGokemon: GokemonUseCase
    @Service private var usecaseGokemonLocal: GokemonLocalUseCase
}

extension GokemonDetailViewModelImpl: GokemonDetailViewModel {
    
    func loadGokemonDetail(url: String, name: String) {
        
        let useCaseGokemonLocal = usecaseGokemonLocal
        
        self.delegate?.onLoading()
        let useCase = usecaseGokemon
        let doFetchOnline = useCase
            .fetchGokemonDetail(url: url)
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .flatMap({ (detail) -> Single<(GokemonDetailModel, GokemonSpeciesModel, GokemonEvoChainModel?)> in
                
                let fetchPokemonInfo = useCase
                    .fetchGokemonSpecies(url: detail.species.url)
                    .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                    .flatMap({ (species) in
                        if let url = species.evolutionChain?.url {
                            let getEvo = useCase
                                .fetchGokemonChainEvo(url: url)
                                .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                            return Single.zip(Single.just(species), getEvo)
                        } else {
                            return Single.zip(Single.just(species), Single.just(GokemonEvoChainModel(id: -1, chain: nil)))
                        }
                    })
                    .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                    .map({ (result) -> (GokemonSpeciesModel, GokemonEvoChainModel?) in
                        let species = result.0
                        let evoChain = result.1
                        
                        if evoChain.id == -1 && evoChain.chain == nil {
                            return (species, nil)
                        } else {
                            return (species, evoChain)
                        }
                    })
                    .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                    .map({ result -> (GokemonDetailModel, GokemonSpeciesModel, GokemonEvoChainModel?) in
                        return (detail, result.0, result.1)
                    })
                    .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                
                return fetchPokemonInfo
            })
            .map({ (detail, _, evo) -> (GokemonDetailModel, GokemonEvoChainModel?) in
                return (detail, evo)
            })
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .flatMap( { (detail, evo) -> Single< (GokemonDetailModel, GokemonEvoChainModel?)> in
                
                return Single.zip(Single.just(detail), Single.just(evo))
            })
            
            
        
        useCaseGokemonLocal
            .getItem(name: name)
            .catchAndReturn(nil)
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .flatMap({ (result) -> Single<(GokemonDetailModel, GokemonEvoChainModel?)> in
                
                if let result {
                    
                    if let getDetail = result.detail?.toOnlinemodel(),
                       let getEvo = result.chainEvo?.toOnlineModel() {
                        return Single.zip(Single.just(getDetail),
                                          Single.just(getEvo))
                    } else {
                        return doFetchOnline
                            .flatMap({ (detail, evo) -> Single<(GokemonDetailModel, GokemonEvoChainModel?)> in
                                return useCaseGokemonLocal
                                    .inputDetail(gokemon: result, detail: detail, evo: evo)
                                    .catch({ error in
                                        return .empty()
                                    })
                                    .andThen(Single.zip(Single.just(detail), Single.just(evo)))
                            })
                    }
                } else {
                    return doFetchOnline
                        .flatMap({ (detail, evo) -> Single<(GokemonDetailModel, GokemonEvoChainModel?)> in
                            return useCaseGokemonLocal
                                .inputData(name: name, url: url)
                                .catch({ error in
                                    return .empty()
                                })
                                .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                                .andThen(useCaseGokemonLocal.getItem(name: name)
                                    .catchAndReturn(nil))
                                .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                                .flatMap({ (result) -> Single<(GokemonDetailModel, GokemonEvoChainModel?)> in
                                    if let result {
                                        return useCaseGokemonLocal
                                            .inputDetail(gokemon: result, detail: detail, evo: evo)
                                            .catch({ error in
                                                return .empty()
                                            })
                                            .andThen(Single.zip(Single.just(detail), Single.just(evo)))
                                    } else {
                                        throw ErrorResponse.CustomError("failed get local gokemon")
                                    }
                                })
                                .catchAndReturn((detail, evo))
                                
                        })
                }
                
            })
            .map({ [weak self] (detail, evo) -> [GokemonInfoModel] in
                
                guard let superSelf = self else {
                    throw ErrorResponse.CustomError("Unknow Error")
                }
                
                var tempData: [GokemonInfoModel] = []
                tempData.append(GokemonInfoModel(typeInfo: .MainInfo, detail: detail, evo: nil))
                tempData.append(GokemonInfoModel(typeInfo: .StatsInfo, detail: detail, evo: nil))
                if let evo {
                    if let getChain = evo.chain {
                        let getEvo = superSelf.searchEvo(data: [getChain], name: name)
                        if getEvo.count > 0 {
                            let newDataEvoChain = ChainModel(isBaby: getChain.isBaby, species: getChain.species, evolutionDetails: getChain.evolutionDetails, evolvesTo: getEvo)
                            let newEvo = GokemonEvoChainModel(id: evo.id, chain: newDataEvoChain)
                            tempData.append(GokemonInfoModel(typeInfo: .EvoInfo, detail: nil, evo: newEvo))
                        }
                        
                    } else {
                        throw ErrorResponse.CustomError("Error get evo value")
                    }
                }
                
                return tempData
            })
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] result in
                self?.gokeminInformation = result
                self?.delegate?.onEndLoad()
                self?.delegate?.onSuccess()
            }, onFailure: { [weak self] error in
                self?.delegate?.onEndLoad()
                self?.delegate?.onError(error: error)
            })
            .disposed(by: disposableBag)
    }
    
    private func chainToArray(data:  GokemonEvoChainModel) {
        
    }
    
    
    
    private func searchEvo(data: [ChainModel], name: String) -> [ChainModel] {
//        if data.species.name == name {
//            return data.evolvesTo
//        } else {
//            return self.searchEvo(data: data, name: name)
//        }
        
        for item in data {
            if item.species.name == name {
                return item.evolvesTo
            } else {
                return self.searchEvo(data: item.evolvesTo, name: name)
            }
        }
        
        return []
    }
}
