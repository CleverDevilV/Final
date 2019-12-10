//
//  GitHubEndPointTests.swift
//  GitRepo
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: GitHubEndPointTests

class GitHubEndPointTests: XCTestCase {
	
	var endPoint: GitHubApi?
	
	override func setUp() {
		super.setUp()
		
	}

	override func tearDown() {
		super.tearDown()
		
		endPoint = nil
	}
	
	func testGitHubApiHttpMetho() {
		
		// arrange
		// act
		endPoint = GitHubApi.user
		// assert
		XCTAssertEqual(endPoint?.httpMethod.rawValue, "GET")
		
	}
	
	func testGitHubApiTaskNotNil() {
		
		// arrange
		// act
		endPoint = GitHubApi.user
		// assert
		XCTAssertNotNil(endPoint?.task)
	}
	
	func testGitHubApiHTTPHeaders() {
		
		// arrange
		// act
		endPoint = GitHubApi.user
		// assert
		XCTAssertEqual(endPoint?.headers, ["Authorization": "token "])
	}

    func testGitHubApiUserFields() {
		
		// arrange
		// act
		endPoint = GitHubApi.user
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "https://api.github.com/user"))
		XCTAssertEqual(endPoint?.path, "")
    }
	
	func testGitHubApiReposFields() {
		
		// arrange
		// act
		endPoint = GitHubApi.repos
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "https://api.github.com/user"))
		XCTAssertEqual(endPoint?.path, "/repos")
	}
	
	func testGitHubApiOneRepoFields() {
		
		// arrange
		// act
		endPoint = GitHubApi.oneRepo(repositoryName: "Bar")
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "https://api.github.com/repos/"))
		XCTAssertEqual(endPoint?.path, "/Bar")
	}
	
	func testGitHubApiCollaboratorsFields() {
		
		// arrange
		// act
		endPoint = GitHubApi.collaborators(repositoryName: "Bar")
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "Bar"))
		XCTAssertEqual(endPoint?.path, "")
	}
	
	func testGitHubApiBrunchesFields() {
		
		// arrange
		// act
		endPoint = GitHubApi.branches(repositoryName: "Bar")
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "Bar"))
		XCTAssertEqual(endPoint?.path, "")
	}
	
	func testGitHubApiCommitsFields() {
		
		// arrange
		// act
		endPoint = GitHubApi.commits(repositoryName: "Bar")
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "Bar"))
		XCTAssertEqual(endPoint?.path, "")
	}
	
	func testGitHubApiOneCommitFields() {
		
		// arrange
		// act
		endPoint = GitHubApi.oneCommit(repositoryName: "Bar")
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "Bar"))
		XCTAssertEqual(endPoint?.path, "")
	}

}
