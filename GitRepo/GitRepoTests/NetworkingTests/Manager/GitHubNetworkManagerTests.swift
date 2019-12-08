//
//  GitHubNetworkManagerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: GitHubNetworkManagerTests
class GitHubNetworkManagerTests: XCTestCase {
	
	var githubManager: NetworkManagerProtocol!
	var session: URLSession!
	
    override func setUp() {
		session = MockUrlSession()
		githubManager = GitHubNetworkManager(with: session)
    }

    override func tearDown() {
		githubManager = nil
		session = nil
    }
	
	func testGetDataIsNil() {
		
		// arrange
		// act
		githubManager.getData(endPoint: FirebaseApi.getProjects) {
			result, error in
		// assert
			XCTAssertNil(result)
			XCTAssertEqual(error, "Unknown end point")
		}
	}
	
	func testDataIsNotNil() {
		// arrange
		// act
//		githubManager.getData(endPoint: GitHubApi.repos) {
//			result, error in
//		// assert
//			XCTAssertNotNil(result)
//			XCTAssertNil(error)
//		}
	}

}
