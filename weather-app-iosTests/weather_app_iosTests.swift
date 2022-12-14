//
//  weather_app_iosTests.swift
//  weather-app-iosTests
//
//  Created by Prayag Gediya on 15/08/22.
//

import XCTest
import Combine
@testable import weather_app_ios

class weather_app_iosTests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testWeatherAPI() {
        let service = DataService()
        let promise = self.expectation(description: "Successfully getting data from API.")

        service.getWeatherData(lat: 23.11, long: 85.33)
            .sink { data in
                switch data {
                case .failure(let error):
                    XCTFail("Error: \(error.localizedDescription)")
                    break
                case .finished:
                    promise.fulfill()
                    break
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
        wait(for: [promise], timeout: 30)
    }

}
