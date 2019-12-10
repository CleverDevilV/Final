//
//  CollaboratorsTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: CollaboratorsTableViewCellTests
class CollaboratorsTableViewCellTests: XCTestCase {
	
	class SpyCollaboratorsTableViewCellDelegate: CollaboratorsTableViewCellDelegate {
		
		var logCollaboratorsTableViewCellDelegate: String?
		
		func addCollaboratorsTable() {
			logCollaboratorsTableViewCellDelegate = "addCollaboratorsTable"
		}
	}
	
	class SpyCollaboratorsTableViewCell: CollaboratorsTableViewCell {
		
		var logCollaboratorsTableViewCell: String?
		
		override func setupViews() {
			logCollaboratorsTableViewCell = "setupViews"
		}
	}
	
	var cell: CollaboratorsTableViewCell!
	var cellDelegate: SpyCollaboratorsTableViewCellDelegate!

    override func setUp() {
		super.setUp()
		
		cell = CollaboratorsTableViewCell()
		cellDelegate = SpyCollaboratorsTableViewCellDelegate()
		cell.delegate = cellDelegate
    }

    override func tearDown() {
		super.tearDown()
		
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
		let spyCell = SpyCollaboratorsTableViewCell()
		// act
		spyCell.setupViews()
		// assert
		XCTAssertEqual(spyCell.logCollaboratorsTableViewCell, "setupViews")
	}

}
