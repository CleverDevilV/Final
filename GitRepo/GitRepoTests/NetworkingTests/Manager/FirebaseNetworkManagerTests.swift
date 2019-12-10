//
//  FirebaseNetworkManagerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: FirebaseNetworkManagerTests
class FirebaseNetworkManagerTests: XCTestCase {
	
	var firebaseManager: NetworkManagerProtocol!
	var session: URLSession!

    override func setUp() {
		super.setUp()
		
		session = MockUrlSession()
		firebaseManager = FirebaseNetworkManager(with: session)
    }

    override func tearDown() {
		super.tearDown()
		
		firebaseManager = nil
		session = nil
    }
	
	func testFirebaseDataIsNil() {
		// arrage
		///act
		firebaseManager.getData(endPoint: GitHubApi.repos) {
			result, error in
			/// assert
			XCTAssertNil(result)
			XCTAssertEqual(error, "Unknown end point")
		}
	}
	
	func testErrorIsNot() {
		// arrange
		// act
		firebaseManager.getData(endPoint: FirebaseApi.getProjects) {
			result, error in
			// assert
			XCTAssertEqual(error, "Plese check your network connection")
		}
	}

}
