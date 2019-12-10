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
	
	class DummyRouter <EndPoint: EndPointType> : NetworkRouter {
		
		func request(_ route: EndPoint, complition: @escaping NetworkRouterCompletion) {
			complition("data".data(using: .utf8), nil, nil)
		}
		
		func cancel() {
		}
	}
	
	var githubManager: NetworkManagerProtocol!
	var session: URLSession!
	
    override func setUp() {
		super.setUp()
		
		session = MockUrlSession()
		githubManager = GitHubNetworkManager(with: session)
    }

    override func tearDown() {
		super.tearDown()
		
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
	
	func testErrorIsNot() {
		// arrange
		// act
		githubManager.getData(endPoint: GitHubApi.repos) {
			result, error in
		// assert
			XCTAssertEqual(error, "Plese check your network connection")
		}
	}

}
