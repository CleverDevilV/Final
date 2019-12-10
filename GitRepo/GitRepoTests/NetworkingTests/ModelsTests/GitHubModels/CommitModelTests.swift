//
//  CommitModelTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: CommitModelTests
class CommitModelTests: XCTestCase {
	
	var commit: Commit!
	var nilCommit: Commit!

    override func setUp() {
		super.setUp()
		
		commit = Commit(sha: nil, message: nil, author: nil, url: "BarBazURL", date: "2019-12-06T23:27:02Z")
		nilCommit = Commit(sha: nil, message: nil, author: nil, url: nil, date: nil)
    }

    override func tearDown() {
		super.tearDown()
		
		commit = nil
		nilCommit = nil
    }
	
	func testGetUrlOfCommit() {
		// arrange
		var url: String?
		var nilUrl: String?
		// act
		url = commit.getUrlOfCommit()
		nilUrl = nilCommit.getUrlOfCommit()
		// assert
		XCTAssertNotNil(url)
		XCTAssertEqual(url, "BarBazURL")
		
		XCTAssertNil(nilUrl)
	}
	
	func testGetUrlOfCommitIsNil() {
		// arrange
		var url: String?
		// act
		url = nilCommit.getUrlOfCommit()
		// assert
		XCTAssertNil(url)
	}
	
	func testGetCommitDateString() {
		// arrange
		var date: String?
		// act
		date = commit.getCommitDateString()
		// assert
		XCTAssertNotNil(date)
		XCTAssertEqual(date, "2019-12-07 02:27:02")
		
	}
	
	func testGetCommitDateStringIsNil() {
		// arrange
		var date: String?
		// act
		date = nilCommit.getCommitDateString()
		// assert
		XCTAssertNil(date)
	}

}
