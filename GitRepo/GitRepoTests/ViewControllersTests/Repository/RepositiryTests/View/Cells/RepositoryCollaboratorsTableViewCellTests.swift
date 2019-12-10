//
//  RepositoryCollaboratorsTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: RepositoryCollaboratorsTableViewCellTests
class RepositoryCollaboratorsTableViewCellTests: XCTestCase {
	
	class SpyRepositoryCollaboratorsTableViewCellDelegate : RepositoryCollaboratorsTableViewCellDelegate {
		
		var log: String?
		
		func showCollaboratorsTable() {
			log = "showCollaboratorsTable"
		}
	}
	
	var cell: RepositoryCollaboratorsTableViewCell!
	var cellDelegate: SpyRepositoryCollaboratorsTableViewCellDelegate!

    override func setUp() {
		super.setUp()
		
		cell = RepositoryCollaboratorsTableViewCell()
		cellDelegate = SpyRepositoryCollaboratorsTableViewCellDelegate()
		cell.delegate = cellDelegate
    }

    override func tearDown() {
		super.tearDown()
		
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
