//
//  LoaderTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: LoaderTests

class LoaderTests: XCTestCase {
	
	var loader: LoaderProtocol!
	var coreDataServise: CoreDataServiceProtocol!
	

    override func setUp() {
		
		loader = Loader(coreDataService: coreDataServise)
    }

    override func tearDown() {
		loader = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
	

}
