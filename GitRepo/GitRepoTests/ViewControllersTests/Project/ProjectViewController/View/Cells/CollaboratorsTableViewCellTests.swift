//
//  CollaboratorsTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class MockCollaboratorsTableViewCellDelegate: CollaboratorsTableViewCellDelegate {
	
	var logCollaboratorsTableViewCellDelegate: String?
	
	func addCollaboratorsTable() {
		logCollaboratorsTableViewCellDelegate = "addCollaboratorsTable"
	}
	
	
}

class MockCollaboratorsTableViewCell: CollaboratorsTableViewCell {
	
	var logCollaboratorsTableViewCell: String?
	
	override func setupViews() {
		logCollaboratorsTableViewCell = "setupViews"
	}
}

/// - Tag: CollaboratorsTableViewCellTests
class CollaboratorsTableViewCellTests: XCTestCase {
	
	var cell: CollaboratorsTableViewCell!
	var cellDelegate: MockCollaboratorsTableViewCellDelegate!

    override func setUp() {
		cell = CollaboratorsTableViewCell()
		cellDelegate = MockCollaboratorsTableViewCellDelegate()
		cell.delegate = cellDelegate
    }

    override func tearDown() {
		cell = nil
		cellDelegate = nil
    }
	
	func testTapCollaboratorsButtonWithDelegate() {
		// arrange
		// act
		cell.tapCollaboratorsButton()
		// assert
		XCTAssertEqual(cellDelegate.logCollaboratorsTableViewCellDelegate, "addCollaboratorsTable")
	}
	
	func testSetupViews() {
		// arrange
		let mockCell = MockCollaboratorsTableViewCell()
		// act
		// assert
		XCTAssertEqual(mockCell.logCollaboratorsTableViewCell, "setupViews")
	}

}
