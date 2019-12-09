//
//  BuilderTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class BuilderTests: XCTestCase {

    override func setUp() {
		super.setUp()
		
    }

    override func tearDown() {
		super.tearDown()
		
    }
	
	func testCreatedStartAppViewControllerIsNotNil () {
		// arrange
		var view = UIViewController()
		// act
		view = Builder.createStartAppViewController()
		// assert
		XCTAssertNotNil(view)
	}
	
	func testCreatedSettingsViewControllerIsNotNil () {
		// arrange
		var view = UIViewController()
		// act
		view = Builder.createSettingsViewController()
		// assert
		XCTAssertNotNil(view)
	}

}
