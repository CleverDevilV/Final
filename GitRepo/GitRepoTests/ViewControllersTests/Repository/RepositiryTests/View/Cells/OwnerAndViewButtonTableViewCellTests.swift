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
	
	class SpyOwnerAndViewButtonTableViewCellDelegate: OwnerAndViewButtonTableViewCellDelegate {
		
		var log: String?
		
		func tapRepoButton() {
			log = "tapRepoButton"
		}
	}
	
	var cell: OwnerAndViewButtonTableViewCell!
	var cellDelegate: SpyOwnerAndViewButtonTableViewCellDelegate!
	var repository: Repository!

    override func setUp() {
		super.setUp()
		
		cell = OwnerAndViewButtonTableViewCell()
		cellDelegate = SpyOwnerAndViewButtonTableViewCellDelegate()
		repository = Repository()
    }

    override func tearDown() {
		super.tearDown()
		
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
		// act
		repository.owner = owner
		cell.repository = repository
		// assert
		XCTAssertEqual(cell.repository?.owner?.login, "Bar")
	}

}
