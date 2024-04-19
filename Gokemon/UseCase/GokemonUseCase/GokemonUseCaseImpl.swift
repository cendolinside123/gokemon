//
//  GokemonUseCaseImpl.swift
//  Gokemon
//
//  Created by Jan Sebastian on 16/04/24.
//

import Foundation
import RxSwift
import Alamofire

struct GokemonUseCaseImpl {
    
}

extension GokemonUseCaseImpl: GokemonUseCase {
    func fetchGokemonDetail(url: String) -> RxSwift.Single<GokemonDetailModel> {
        return Single.create(subscribe: { emmiter in
            
            AF.request(url, method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    do {
                        let getData = try JSONDecoder().decode(GokemonDetailModel.self, from: data)
                        emmiter(.success(getData))
                    } catch let error as NSError {
                        emmiter(.failure(error))
                    }
                case .failure(let error):
                    emmiter(.failure(error))
                }
            })
            
            return Disposables.create()
        }).retry(3)
    }
    
    func fetchGokemonChainEvo(url: String) -> RxSwift.Single<GokemonEvoChainModel> {
        return Single.create(subscribe: { emmiter in
            
            AF.request(url, method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    do {
                        let getData = try JSONDecoder().decode(GokemonEvoChainModel.self, from: data)
                        emmiter(.success(getData))
                    } catch let error as NSError {
                        emmiter(.failure(error))
                    }
                case .failure(let error):
                    emmiter(.failure(error))
                }
            })
            
            return Disposables.create()
        }).retry(3)
    }
    
    func fetchGokemonSpecies(url: String) -> RxSwift.Single<GokemonSpeciesModel> {
        return Single.create(subscribe: { emmiter in
            
            AF.request(url, method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    do {
                        let getData = try JSONDecoder().decode(GokemonSpeciesModel.self, from: data)
                        emmiter(.success(getData))
                    } catch let error as NSError {
                        emmiter(.failure(error))
                    }
                case .failure(let error):
                    emmiter(.failure(error))
                }
            })
            
            return Disposables.create()
        }).retry(3)
    }
    
    func fetchListGokemom(offset: Int, limit: Int) -> RxSwift.Single<GokemonResponse> {
        return Single.create(subscribe: { emmiter in
            
            AF.request("https://pokeapi.co/api/v2/pokemon/", method: .get,
                       parameters: ["offset":offset,
                                    "limit": limit],
                       encoding: URLEncoding.default)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    do {
                        let getData = try JSONDecoder().decode(GokemonResponse.self, from: data)
                        emmiter(.success(getData))
                    } catch let error as NSError {
                        emmiter(.failure(error))
                    }
                case .failure(let error):
                    emmiter(.failure(error))
                }
            })
            
            return Disposables.create()
        }).retry(3)
    }
    
    
}
