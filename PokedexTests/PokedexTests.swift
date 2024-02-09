//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Etienne Vautherin on 09/02/2024.
//

import XCTest
@testable import Pokedex

final class PokedexTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

//    func testApi() throws {
//        Task {
//            // Create a URL for a webpage to download.
//            let url = URL(string: "https://apple.com")!
//            
//            // Use an asynchronous function to download the webpage.
//            let dataAndResponse: (data: Data, response: URLResponse) = try await URLSession.shared.data(from: url, delegate: nil)
//            
//            // Assert that the actual response matches the expected response.
//            let httpResponse = try XCTUnwrap(dataAndResponse.response as? HTTPURLResponse, "Expected an HTTPURLResponse.")
//            XCTAssertEqual(httpResponse.statusCode, 200, "Expected a 200 OK response.")
//
//        }
//    }
//    
//    func test_pokemonLinks_PropertyChange() {
//        let model = ApiModel.shared
//        let expectation = XCTestExpectation(description: "pokemonLinks property should change")
//
//        @Sendable func observe() {
//            withObservationTracking {
//                if model.pokemonLinks.count > 0 {
//                    expectation.fulfill()
//                }
//            } onChange: {
//                DispatchQueue.main.async(execute: observe)
//            }
//        }
//        observe()
//
//        wait(for: [expectation], timeout: 1)
//    }

//    func test_pokemonLinks_Value() {
//        let model = ApiModel.shared
//        let expectation = XCTestExpectation(description: "pokemonLinks property should change")
//
//        @Sendable func observe() {
//            withObservationTracking {
//                if model.pokemonLinks.count > 0 {
//                    if model.pokemonLinks[0].name == "bulbasaur" {
//                        expectation.fulfill()
//                    }
//                }
//            } onChange: {
//                DispatchQueue.main.async(execute: observe)
//            }
//        }
//        observe()
//
//        wait(for: [expectation], timeout: 1)
//    }

    func test_pokemonLinks_Value() {
        
        func waitForChanges<T, U>(to keyPath: KeyPath<T, U>, on parent: T, timeout: Double = 1.0) {
            let exp = expectation(description: #function)
            withObservationTracking {
                _ = parent[keyPath: keyPath]
            } onChange: {
                exp.fulfill()
            }
            waitForExpectations(timeout: timeout)
        }
        
        let sut = ApiModel(gettingPokemonLinks: false)
        sut.getPokemonLinks()
        waitForChanges(to: \.pokemonLinks, on: sut)
        
        XCTAssertGreaterThan(sut.pokemonLinks.count, 0)
        guard sut.pokemonLinks.count > 0 else { return }
        
        XCTAssertEqual(sut.pokemonLinks[0].name, "bulbasaur")
    }

}
