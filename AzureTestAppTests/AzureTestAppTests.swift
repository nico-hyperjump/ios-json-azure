//
//  AzureTestAppTests.swift
//  AzureTestAppTests
//
//  Created by nico on 07.06.20.
//  Copyright © 2020 nico. All rights reserved.
//

import XCTest
@testable import AzureTestApp

class AzureTestAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPing() throws {
        let expectation = XCTestExpectation(description: "ping test")
        class FakeDelegate: BaseDelegate<TheResponse> {
            var _didLoad: ((TheResponse) -> Void)?
            override func didLoad(data: TheResponse) {
                self._didLoad?(data)
            }
        }
        let delegate = FakeDelegate()
        delegate._didLoad = { data in
            XCTAssertNotNil(data)
            XCTAssertEqual(data.name, "hello")
            expectation.fulfill()
        }
        let loader = APILoader()
        loader.delegate = delegate
        loader.load()
        
        wait(for: [expectation], timeout: 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
