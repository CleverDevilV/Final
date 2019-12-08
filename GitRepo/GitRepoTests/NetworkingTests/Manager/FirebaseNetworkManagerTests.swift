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
		session = MockUrlSession()
		firebaseManager = FirebaseNetworkManager(with: session)
    }

    override func tearDown() {
		firebaseManager = nil
		session = nil
    }
	
	func testFirebaseDataIsNil() {
		firebaseManager.getData(endPoint: GitHubApi.repos) {
			result, error in
			XCTAssertNil(result)
			XCTAssertEqual(error, "Unknown end point")
		}
	}

}
