//
//  GokemonDetailTests.swift
//  GokemonTests
//
//  Created by Jan Sebastian on 18/04/24.
//

import XCTest
@testable import Gokemon


class GokemonDetailTests: XCTestCase {
    
    class GokemonDetailMokup: GokemonDetailDelegate {
        
        var viewModel: GokemonDetailViewModel = GokemonDetailViewModelImpl()
        var listData: [GokemonInfoModel] = []
        var errorResponse: Error?
        var expectation: XCTestExpectation?
        
        init() {
            self.viewModel.delegate = self
        }
        
        
        func onSuccess() {
            listData = viewModel.gokeminInformation
            expectation?.fulfill()
        }
        
        func onError(error: Error) {
            errorResponse = error
            expectation?.fulfill()
        }
        
        func onEndLoad() {
            
        }
        
        func onLoading() {
            
        }
        
    }
    
    override func setUp() {
//        CoreDataStack.shared.isTestOnly = true
        CoreDataStack.shared.doTestSetup()
        ServiceContainer.register(type: GokemonUseCase.self, GokemonUseCaseImpl())
        ServiceContainer.register(type: GokemonLocalUseCase.self, GokemonLocalUseCaseImpl())
    }
    
    func testLoadInformation() {
        let expectation = XCTestExpectation(description: "Delegate receives events")
        
        let mockupClass = GokemonDetailMokup()
        mockupClass.expectation = expectation
        
        mockupClass.viewModel.loadGokemonDetail(url: "https://pokeapi.co/api/v2/pokemon/1/", name: "bulbasaur")
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        if result == XCTWaiter.Result.completed {
            XCTAssert(mockupClass.errorResponse == nil, "test berhasil")
            XCTAssert(mockupClass.listData.count > 0, "data tidak kosong")
            XCTAssert(mockupClass.listData.count == 2, "data lengkap")
            XCTAssert(mockupClass.listData[1].typeInfo == .EvoInfo, "data evo tersedia")
        } else {
            XCTAssert(false, "req timeout")
        }
        
        
    }
    
}
