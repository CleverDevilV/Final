//
//  RepoViewControllerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 10/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: RepoViewControllerTests
class RepoViewControllerTests: XCTestCase {
	
	var repositoryView: RepoViewController!

    override func setUp() {
		super.setUp()
		
		repositoryView = RepoViewController()
    }

    override func tearDown() {
		super.tearDown()
		
		repositoryView = nil
    }
	
	func testClassOfCellOnView () {
		// arrange
		var defaultCell: UITableViewCell?
		var testOwnerCell: UITableViewCell?
		var testRepositoryCell: UITableViewCell?
		var testSegmentCell: UITableViewCell?
	
		let testTableView = UITableView()
		testTableView.dataSource = repositoryView
		
		testTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		
		testTableView.register(OwnerAndViewButtonTableViewCell.self, forCellReuseIdentifier: OwnerAndViewButtonTableViewCell.ownerReuseId)
		testTableView.register(RepositoryCollaboratorsTableViewCell.self, forCellReuseIdentifier: RepositoryCollaboratorsTableViewCell.collaboratorsReuseId)
		testTableView.register(SegmentCommitsBranchesTableViewCell.self, forCellReuseIdentifier: SegmentCommitsBranchesTableViewCell.separatorCommitsBranchesReuseId)
		
		// act
		defaultCell = repositoryView.tableView(testTableView, cellForRowAt: IndexPath(row: 6, section: 0))
		testOwnerCell = repositoryView.tableView(testTableView, cellForRowAt: IndexPath(row: 0, section: 0))
		testRepositoryCell = repositoryView.tableView(testTableView, cellForRowAt: IndexPath(row: 1, section: 0))
		testSegmentCell = repositoryView.tableView(testTableView, cellForRowAt: IndexPath(row: 2, section: 0))
		
		// assert
		XCTAssertTrue(defaultCell != nil)
		XCTAssertTrue(testOwnerCell is OwnerAndViewButtonTableViewCell)
		XCTAssertTrue(testRepositoryCell is RepositoryCollaboratorsTableViewCell)
		XCTAssertTrue(testSegmentCell is SegmentCommitsBranchesTableViewCell)
	}

}
