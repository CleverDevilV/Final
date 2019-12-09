//
//  RepositoryCollaboratorsTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class RepositoryCollaboratorsTableViewCellTests: XCTestCase {
	
	class MockRepositoryCollaboratorsTableViewCellDelegate : RepositoryCollaboratorsTableViewCellDelegate {
		
		var log: String?
		
		func showCollaboratorsTable() {
			log = "showCollaboratorsTable"
		}
	}
	
	var cell: RepositoryCollaboratorsTableViewCell!
	var cellDelegate: MockRepositoryCollaboratorsTableViewCellDelegate!

    override func setUp() {
		cell = RepositoryCollaboratorsTableViewCell()
		cellDelegate = MockRepositoryCollaboratorsTableViewCellDelegate()
		cell.delegate = cellDelegate
    }

    override func tearDown() {
		cell = nil
		cellDelegate = nil
    }
	
	func testCollaboratorsButtonTappedWithDelegate () {
		// arrange
		// act
		cell.collaboratorsButtonTapped()
		// assert
		XCTAssertEqual(cellDelegate.log, "showCollaboratorsTable")
	}

}
