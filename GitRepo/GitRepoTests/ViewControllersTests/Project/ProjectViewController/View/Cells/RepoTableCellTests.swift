//
//  RepoTableCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: RepoTableCellTests
class RepoTableCellTests: XCTestCase {
	
	class SpyRepoTableCellDelegate: RepoTableCellDelegate {
		var log: String?
		func setupRepo() {
			log = "setupRepo"
		}
	}
	
	class SpyRepoTableViewCell: RepoTableViewCell{
		
		var logRepoTableViewCell: String?
		
		override func setupViews() {
			logRepoTableViewCell = project?.projectName
		}
	}
	
	var cell: RepoTableViewCell!
	var cellDelegate: SpyRepoTableCellDelegate!
	
	var project: Project!

    override func setUp() {
		super.setUp()
		
		cell = RepoTableViewCell()
		cellDelegate = SpyRepoTableCellDelegate()
		cell.delegate = cellDelegate
		
		project = Project(projectName: "Bar", repoURL: "Foo", repositoryName: "Baz", repo: nil, descriptionOfProject: nil, languageOfProject: nil)
    }

    override func tearDown() {
		super.tearDown()
		
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
		let spyCell = SpyRepoTableViewCell()
		// act
		spyCell.project = project
		// assert
		XCTAssertEqual(spyCell.logRepoTableViewCell, "Bar")
	}

}
