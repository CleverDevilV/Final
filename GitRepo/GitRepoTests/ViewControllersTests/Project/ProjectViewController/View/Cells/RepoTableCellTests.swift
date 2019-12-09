//
//  RepoTableCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class MockRepoTableCellDelegate: RepoTableCellDelegate {
	var log: String?
	func setupRepo() {
		log = "setupRepo"
	}
}

class MockRepoTableViewCell: RepoTableViewCell{
	
	var logRepoTableViewCell: String?
	
	override func setupViews() {
		logRepoTableViewCell = project?.projectName
	}
}

class RepoTableCellTests: XCTestCase {
	
	var cell: RepoTableViewCell!
	var cellDelegate: MockRepoTableCellDelegate!
	
	var project: Project!

    override func setUp() {
		cell = RepoTableViewCell()
		cellDelegate = MockRepoTableCellDelegate()
		cell.delegate = cellDelegate
		
		project = Project(projectName: "Bar", repoURL: "Foo", repositoryName: "Baz", repo: nil, descriptionOfProject: nil, languageOfProject: nil)
    }

    override func tearDown() {
		cell = nil
		cellDelegate = nil
    }
	
	func testTapRepoButtonWithDelegate() {
		// arrange
		// act
		cell.tapRepoButton()
		// assert
		XCTAssertEqual(cellDelegate.log, "setupRepo")
	}
	
	func testSetupProject() {
		// arrange
		let mockCell = MockRepoTableViewCell()
		// act
		mockCell.project = project
		// assert
		XCTAssertEqual(mockCell.logRepoTableViewCell, "Bar")
	}

}
