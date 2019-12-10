//
//  LogOutCommandTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: LogOutCommandTests
class LogOutCommandTests: XCTestCase {
	
	var command: LogOutCommand!

    override func setUp() {
		super.setUp()
		
		command = LogOutCommand()
    }

    override func tearDown() {
		super.tearDown()
		
		command = nil
    }
	
	func testResetUserDefaults() {
		// arrange
		// act
		command.logOut()
		// assert
		XCTAssertFalse(UserDefaults.standard.isExist(with: UserDefaultsType.oauth_user_login))
		XCTAssertFalse(UserDefaults.standard.isExist(with: UserDefaultsType.oauth_access_token))
	}

}
