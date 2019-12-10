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
	var firebaseApiKey = UserDefaults.standard.get(with: UserDefaultsType.firebase_apiKey)

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
		UserDefaults.standard.update(with: UserDefaultsType.firebase_apiKey, data: firebaseApiKey)
    }
	
	func testUpdateData () {
		// arrange
		// act
		UserDefaults.standard.update(with: UserDefaultsType.oauth_access_token, data: "Bazr")
		UserDefaults.standard.update(with: UserDefaultsType.oauth_user_login, data: "Foo")
		UserDefaults.standard.update(with: UserDefaultsType.firebase_apiKey, data: "Barz")
        // assert
		XCTAssertEqual(UserDefaults.standard.get(with: UserDefaultsType.oauth_access_token), "Bazr")
		XCTAssertEqual(UserDefaults.standard.get(with: UserDefaultsType.oauth_user_login), "Foo")
		XCTAssertEqual(UserDefaults.standard.get(with: UserDefaultsType.firebase_apiKey), "Barz")
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
		UserDefaults.standard.remove(with: UserDefaultsType.firebase_apiKey)
		// assert
		XCTAssertEqual(UserDefaults.standard.get(with: UserDefaultsType.oauth_user_login), "")
		XCTAssertEqual(UserDefaults.standard.get(with: UserDefaultsType.oauth_access_token), "")
		XCTAssertEqual(UserDefaults.standard.get(with: UserDefaultsType.firebase_apiKey), "")
	}
	
	func testIsExistDataAfterRemove() {
		// arrange
		// act
		UserDefaults.standard.remove(with: UserDefaultsType.oauth_user_login)
		UserDefaults.standard.remove(with: UserDefaultsType.oauth_access_token)
		UserDefaults.standard.remove(with: UserDefaultsType.firebase_apiKey)
		// assert
		XCTAssertFalse(UserDefaults.standard.isExist(with: UserDefaultsType.oauth_access_token))
		XCTAssertFalse(UserDefaults.standard.isExist(with: UserDefaultsType.oauth_user_login))
		XCTAssertFalse(UserDefaults.standard.isExist(with: UserDefaultsType.firebase_apiKey))
	}
	
	
	func testErrorsWhenSetData() {
		// arrange
		// act
		UserDefaults.standard.update(with: UserDefaultsType.oauth_access_token, data: 123)
		UserDefaults.standard.update(with: UserDefaultsType.oauth_user_login, data: 123)
		UserDefaults.standard.update(with: UserDefaultsType.firebase_apiKey, data: 123)
		// assert
		XCTAssertNotEqual(Int(UserDefaults.standard.get(with: UserDefaultsType.oauth_access_token)), 123)
		XCTAssertNotEqual(Int(UserDefaults.standard.get(with: UserDefaultsType.oauth_user_login)), 123)
		XCTAssertNotEqual(Int(UserDefaults.standard.get(with: UserDefaultsType.firebase_apiKey)), 123)
	}

}
