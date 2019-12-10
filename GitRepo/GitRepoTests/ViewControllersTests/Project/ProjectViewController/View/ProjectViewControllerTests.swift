//
//  ProjectViewControllerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: ProjectViewControllerTests
class ProjectViewControllerTests: XCTestCase {
	
	var projectView: ProjectViewController!

    override func setUp() {
		super.setUp()
		
		projectView = ProjectViewController()
    }

    override func tearDown() {
		super.tearDown()
		
		projectView = nil
    }
	
	func testDescriptionDelegating () {
		// arrange
		let project = Project(projectName: "Baz", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: nil, languageOfProject: nil)
		let cell = DescriptionTableViewCell()
		let testView = UITextView()
		testView.text = "Bar"
		// act
		cell.descriptionCellDelegate = projectView
		projectView.setupProject(project)
		cell.textViewDidEndEditing(testView)
		
		// assert
		XCTAssertEqual(project.descriptionOfProject, "Bar")
	}
	
	func testClassOfCellOnView() {
		// arrange
		var testDescriptionCell: UITableViewCell?
		var testRepoCell: UITableViewCell?
		var testCollaboratorsnCell: UITableViewCell?
		var testTasksCell: UITableViewCell?
		var defaultCell: UITableViewCell?
		
		let testTableView = UITableView()
		
		testTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		testTableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.descriptionReuseId)
		testTableView.register(RepoTableViewCell.self, forCellReuseIdentifier: RepoTableViewCell.repoReuseId)
		testTableView.register(CollaboratorsTableViewCell.self, forCellReuseIdentifier: CollaboratorsTableViewCell.collaboratorsReuseId)
		testTableView.register(TasksTableViewCell.self, forCellReuseIdentifier: TasksTableViewCell.tasksReuseId)
		
		testTableView.dataSource = projectView
		
		// act
		defaultCell = projectView?.tableView(testTableView, cellForRowAt: IndexPath(row: 4, section: 0))
		testDescriptionCell = projectView?.tableView(testTableView, cellForRowAt: IndexPath(row: 0, section: 0))
		testRepoCell = projectView?.tableView(testTableView, cellForRowAt: IndexPath(row: 1, section: 0))
		testCollaboratorsnCell = projectView?.tableView(testTableView, cellForRowAt: IndexPath(row: 2, section: 0))
		testTasksCell = projectView?.tableView(testTableView, cellForRowAt: IndexPath(row: 3, section: 0))
		
		// assert
		XCTAssertTrue(defaultCell != nil)
		XCTAssertTrue(testDescriptionCell is DescriptionTableViewCell)
		XCTAssertTrue(testRepoCell is RepoTableViewCell)
		XCTAssertTrue(testCollaboratorsnCell is CollaboratorsTableViewCell)
		XCTAssertTrue(testTasksCell is TasksTableViewCell)
	}
}
