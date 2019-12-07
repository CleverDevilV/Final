//
//  LoaderBuilderTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: LoaderBuilderTests
class LoaderBuilderTests: XCTestCase {

	var loader: LoaderProtocol!
	
    override func setUp() {
		
    }

    override func tearDown() {
		loader = nil
    }
	
	func testLoaderNotNilAfterBuilding() {
		// arrange
		// act
//		loader = LoaderBuilder.createLoader()
		// assert
//		XCTAssertNotNil(loader)
	}

}
