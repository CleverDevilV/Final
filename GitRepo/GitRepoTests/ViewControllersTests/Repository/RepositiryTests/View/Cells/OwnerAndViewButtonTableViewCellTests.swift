//
//  OwnerAndViewButtonTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: OwnerAndViewButtonTableViewCellTests
class OwnerAndViewButtonTableViewCellTests: XCTestCase {
	
	class MockOwnerAndViewButtonTableViewCellDelegate: OwnerAndViewButtonTableViewCellDelegate {
		
		var log: String?
		
		func tapRepoButton() {
			log = "tapRepoButton"
		}
	}
	
	var cell: OwnerAndViewButtonTableViewCell!
	var cellDelegate: MockOwnerAndViewButtonTableViewCellDelegate!
	var repository: Repository!

    override func setUp() {
		cell = OwnerAndViewButtonTableViewCell()
		cellDelegate = MockOwnerAndViewButtonTableViewCellDelegate()
		repository = Repository()
    }

    override func tearDown() {
		cell = nil
		cellDelegate = nil
		repository = nil
    }
	
	func testTapRepoViewButtonWithDelegate() {
		// arrange
		cell.delegate = cellDelegate
		// act
		cell.tapRepoViewButton()
		// assert
		XCTAssertEqual(cellDelegate.log, "tapRepoButton")
	}
	
	func testWithNotNilRepository() {
		// arrange
		let owner = User(login: "Bar")
		repository.owner = owner
		// act
		
		cell.repository = repository
		// assert
		XCTAssertEqual(cell.repository?.owner?.login, "Bar")
	}

}
