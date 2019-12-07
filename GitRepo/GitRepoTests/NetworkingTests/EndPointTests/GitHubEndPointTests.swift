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
//		UserDefaults.standard.update(with: .oauth_access_token, data: "Bar")
//		UserDefaults.standard.update(with: .oauth_user_login, data: "Baz")
	}

	override func tearDown() {
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
		endPoint = GitHubApi.repos
		// act
		
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "https://api.github.com/user"))
		XCTAssertEqual(endPoint?.path, "/repos")
	}
	
	func testGitHubApiOneRepoFields() {
		
		// arrange
		endPoint = GitHubApi.oneRepo(repositoryName: "Bar")
		// act
		
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "https://api.github.com/repos/"))
		XCTAssertEqual(endPoint?.path, "/Bar")
	}
	
	func testGitHubApiCollaboratorsFields() {
		
		// arrange
		endPoint = GitHubApi.collaborators(repositoryName: "Bar")
		// act
		
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "Bar"))
		XCTAssertEqual(endPoint?.path, "")
	}
	
	func testGitHubApiBrunchesFields() {
		
		// arrange
		endPoint = GitHubApi.branches(repositoryName: "Bar")
		// act
		
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "Bar"))
		XCTAssertEqual(endPoint?.path, "")
	}
	
	func testGitHubApiCommitsFields() {
		
		// arrange
		endPoint = GitHubApi.commits(repositoryName: "Bar")
		// act
		
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "Bar"))
		XCTAssertEqual(endPoint?.path, "")
	}
	
	func testGitHubApiOneCommitFields() {
		
		// arrange
		endPoint = GitHubApi.oneCommit(repositoryName: "Bar")
		// act
		
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "Bar"))
		XCTAssertEqual(endPoint?.path, "")
	}

}
