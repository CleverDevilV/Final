//
//  StartAppViewControllerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: StartAppViewControllerTests
class StartAppViewControllerTests: XCTestCase {
	
	var view: StartAppViewController!
	var mockLoader: MockLoader!
	var spyLogoutCommand: SpyLogoutCommand!
	
	

    override func setUp() {
		super.setUp()
		
		view = StartAppViewController()
		mockLoader = MockLoader()
		spyLogoutCommand = SpyLogoutCommand()
    }

    override func tearDown() {
		super.tearDown()
		
		view = nil
		mockLoader = nil
		spyLogoutCommand = nil
    }

	func testTapLogOutButtonFunc () {
		// arrange
		// act
		view.setLogoutCommand(command: spyLogoutCommand)
		view.tapLogOutButton()
		// assert
		XCTAssertEqual(spyLogoutCommand.log, "log out command")
	}
	
	func testSetupLoader() {
		// arrange
		// act
		view.setLoader(loader: mockLoader)
		// assert
		XCTAssertEqual(mockLoader.log, "loader created")
	}
	
	func testResetUserNameWhenTapLogOutButton () {
		// arrange
		let logoutCommand = LogOutCommand()
		// act
		view.setLogoutCommand(command: logoutCommand)
		view.tapLogOutButton()
		// assert
		XCTAssertFalse(UserDefaults.standard.isExist(with: UserDefaultsType.oauth_user_login))
	}

}
