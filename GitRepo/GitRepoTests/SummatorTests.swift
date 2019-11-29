//
//  SummatorTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 26/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class SummatorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatSummatorReturnCorrectValue () {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		
//		let summOpt: Int?
//		let c: Int = summOpt!
		
		// arrange
		let summ: Summator = Summator(a: 3, b: 7)
		// act
		let result = summ.sum()
		// assert
		XCTAssertEqual(10, result)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
