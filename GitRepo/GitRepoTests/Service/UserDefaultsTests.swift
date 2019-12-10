//
//  UserDefaultsTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: UserDefaultsTests
class UserDefaultsTests: XCTestCase {
	
	var token = UserDefaults.standard.get(with: UserDefaultsType.oauth_access_token)
	var login = UserDefaults.standard.get(with: UserDefaultsType.oauth_user_login)

    override func setUp() {
		super.setUp()
		
		UserDefaults.standard.update(with: UserDefaultsType.firebase_apiKey, data: "Bar")
		UserDefaults.standard.update(with: UserDefaultsType.oauth_access_token, data: "Baz")
		UserDefaults.standard.update(with: UserDefaultsType.oauth_user_login, data: "Foo")
    }

    override func tearDown() {
		super.tearDown()
		
		UserDefaults.standard.update(with: UserDefaultsType.oauth_access_token, data: token)
		UserDefaults.standard.update(with: UserDefaultsType.oauth_user_login, data: login)
    }
	
	func testUpdateData () {
		// arrange
		let testData = OAuthResponse(access_token: "Bar", scope: "", token_type: "")
		// act
		UserDefaults.standard.update(with: UserDefaultsType.oauth_access_token, data: testData)
		UserDefaults.standard.update(with: UserDefaultsType.oauth_access_token, data: "Baz")
		UserDefaults.standard.update(with: UserDefaultsType.oauth_user_login, data: "Foo")
        // assert
		XCTAssertEqual(UserDefaults.standard.get(with: UserDefaultsType.oauth_access_token), "Baz")
		XCTAssertEqual(UserDefaults.standard.get(with: UserDefaultsType.oauth_user_login), "Foo")
	}
	
	func testUpdateWithOAuthResponseData () {
		// arrange
		let testData = OAuthResponse(access_token: "Bar", scope: "", token_type: "")
		// act
		UserDefaults.standard.update(with: UserDefaultsType.oauth_access_token, data: testData)
		// assert
		XCTAssertEqual(UserDefaults.standard.get(with: UserDefaultsType.oauth_access_token), "Bar")
	}
	
	func testRemoveData() {
		// arrange
		// act
		UserDefaults.standard.remove(with: UserDefaultsType.oauth_user_login)
		UserDefaults.standard.remove(with: UserDefaultsType.oauth_access_token)
		// assert
		XCTAssertEqual(UserDefaults.standard.get(with: UserDefaultsType.oauth_user_login), "")
		XCTAssertEqual(UserDefaults.standard.get(with: UserDefaultsType.oauth_access_token), "")
	}
	
	func testIsExist() {
		// arrange
		// act
		// assert
		XCTAssertFalse(UserDefaults.standard.isExist(with: UserDefaultsType.firebase_apiKey))
		XCTAssertTrue(UserDefaults.standard.isExist(with: UserDefaultsType.oauth_access_token))
		XCTAssertTrue(UserDefaults.standard.isExist(with: UserDefaultsType.oauth_user_login))
	}

}
