//
//  ListLoadViewModelImpl.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import Foundation
import RxSwift
import RxCocoa

class ListLoadViewModelImpl {
    weak var delegate: ListLoadDelegate?
    var listData: [GokemonModel] = []
    
    private let streamLoad: PublishSubject<Bool> = PublishSubject()
    private var disposableBag = DisposeBag()
    private var currentOffsite: Int = 0
    private var onLoad: Bool = false
    @Service private var usecaseGokemon: GokemonUseCase
    @Service private var usecaseGokemonLocal: GokemonLocalUseCase
    
    
    init() {
        streamLoad
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .filter({ [weak self] _ in
                !(self?.onLoad ?? false)
            })
            .subscribe(onNext: { [weak self] isFirstLoad in
                self?.doFetch(fistLoad: isFirstLoad)
            }, onError: { error in
                
            }).disposed(by: disposableBag)
    }
    
}

extension ListLoadViewModelImpl: ListLoadViewModel {
    func loadListGokemon(fistLoad: Bool) {
        streamLoad.onNext(fistLoad)
    }
    
    func changeOffset(offset: Int) {
        
    }
}

extension ListLoadViewModelImpl {
    private func doFetch(fistLoad: Bool) {
        onLoad = true
        let usecaseGokemon = self.usecaseGokemon
        let usecaseGokemonLocal = self.usecaseGokemonLocal
        self.delegate?.onLoading()
        
        if fistLoad {
            currentOffsite = 0
        }
        
        let loadTemp = usecaseGokemonLocal
            .fetchData(limit: 20, offset: currentOffsite)
            .catchAndReturn([])
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .map({ (listItem) -> [GokemonModel] in
                var tempData: [GokemonModel] = []
                
                for item in listItem {
                    if let getOnlineItem = item.toOnlinemodel() {
                        tempData.append(getOnlineItem)
                    }
                }
                
                return tempData
            })
            .observe(on: MainScheduler.instance)
            .do(onSuccess: { [weak self] limitItem in
                if fistLoad {
                    self?.listData = limitItem
                    self?.delegate?.onSuccessLoad()
                }
            })
        
        let localTask = Single.zip(
            loadTemp,
            usecaseGokemonLocal.fetchData().catchAndReturn([]),
            usecaseGokemon.fetchListGokemom(offset: currentOffsite, limit: 20)
        )
        
        localTask
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .map({ (limitItem, allItem, onlineResult) -> ([GokemonModel], [GokemonModel]) in
                var tempAllData: [GokemonModel] = []
                
                for item in allItem {
                    if let getOnlineItem = item.toOnlinemodel() {
                        tempAllData.append(getOnlineItem)
                    }
                }
                
                let listOnline: Set<GokemonModel> = Set(onlineResult.results)
                let setupLocalData: Set<GokemonModel> = Set(tempAllData)

                let getDifference = listOnline.subtracting(setupLocalData)
                return (Array(listOnline), Array(getDifference))
            })
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .flatMap({ (onlineItem, listDifference) -> Single<[GokemonModel]> in
                
                if listDifference.count > 0 {
                    var listInput: [Completable] = []
                    
                    for item in listDifference {
                        let doInput = usecaseGokemonLocal
                            .inputData(name: item.name, url: item.url)
                            .catch({ error in
                                return Completable.empty()
                            })
                        listInput.append(doInput)
                    }
                    
                    let doInput = Completable.zip(listInput).andThen(Single.just(onlineItem))
                    return doInput
                } else {
                    return Single.just(onlineItem)
                }
                
            })
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] item in
                if fistLoad {
                    self?.listData = item
                } else {
                    self?.listData += item
                }
                self?.onLoad = false
                self?.currentOffsite += 20
                self?.delegate?.onSuccessLoad()
                self?.delegate?.finishLoading()
            }, onFailure: { [weak self] error in
                self?.onLoad = false
                self?.delegate?.finishLoading()
                self?.delegate?.onError(error: error)
            }, onDisposed: nil)
            .disposed(by: disposableBag)
    }
}
