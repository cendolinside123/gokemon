//
//  GokemonTests.swift
//  GokemonTests
//
//  Created by Jan Sebastian on 17/04/24.
//

import XCTest
@testable import Gokemon

final class GokemonTests: XCTestCase {
    
    class MockGokemonDelegate: ListLoadDelegate {
        
        var viewModel: ListLoadViewModel = ListLoadViewModelImpl()
        var error: Error?
        var listDataLog: [[Gokemon.GokemonModel]] = []
        
        var expectation: XCTestExpectation?
            
        init() {
            self.viewModel.delegate = self
        }
        
        func onSuccessLoad() {
            listDataLog.append(viewModel.listData)
            expectation?.fulfill()
        }
        
        func onError(error: Error) {
            self.error = error
            expectation?.fulfill()
        }
        
        func onLoading() {
            
        }
        
        func finishLoading() {
            
        }
    }

    
    
    override func setUp() {
        CoreDataStack.shared.isTestOnly = true
        CoreDataStack.shared.doTestSetup()
        ServiceContainer.register(type: GokemonUseCase.self, GokemonUseCaseImpl())
        ServiceContainer.register(type: GokemonLocalUseCase.self, GokemonLocalUseCaseImpl())
    }
    
    // MARK: Only use this test on first install
    func testFirstLoadPokemon() {
        let expectation = XCTestExpectation(description: "Delegate receives events")
        expectation.expectedFulfillmentCount = 2
        let mockDelegate = MockGokemonDelegate()
        mockDelegate.expectation = expectation
        
        mockDelegate.viewModel.loadListGokemon(fistLoad: true)
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        if result == XCTWaiter.Result.completed {
            XCTAssert(mockDelegate.listDataLog.count == 2, "Delegate should receive two events")
            XCTAssert(mockDelegate.listDataLog[0].count == 0, "first call should be empty")
            XCTAssert(mockDelegate.listDataLog[1].count > 0, "second call should not empty")
        } else {
            XCTAssert(false, "req timeout")
        }
        
    }

    
    func testLoadPokemon() {
        let expectation = XCTestExpectation(description: "Delegate receives events")
        
        expectation.expectedFulfillmentCount = 2
        let mockDelegate = MockGokemonDelegate()
        mockDelegate.expectation = expectation
         
        mockDelegate.viewModel.loadListGokemon(fistLoad: true)
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        if result == XCTWaiter.Result.completed {
            XCTAssert(mockDelegate.listDataLog.count == 2, "Delegate should receive two events")
            XCTAssert(mockDelegate.listDataLog[0].count > 0, "first call should be empty")
            XCTAssert(mockDelegate.listDataLog[1].count > 0, "second call should not empty")
            
            let secondExpectation = XCTestExpectation(description: "Delegate receives new events")
            mockDelegate.expectation = secondExpectation
            mockDelegate.viewModel.loadListGokemon(fistLoad: false)
            let resultSecond = XCTWaiter.wait(for: [secondExpectation], timeout: 5)
            
            if resultSecond == XCTWaiter.Result.completed {
                XCTAssert(mockDelegate.listDataLog.count == 3, "Delegate should receive three events")
                XCTAssert(mockDelegate.listDataLog[0].count > 0, "first call should be empty")
                XCTAssert(mockDelegate.listDataLog[1].count > 0, "second call should not empty")
                XCTAssert(mockDelegate.listDataLog[2].count > 0, "third call should not empty")
            } else {
                XCTAssert(false, "req timeout")
            }
            
        } else {
            XCTAssert(false, "req timeout")
        }
     }
}
