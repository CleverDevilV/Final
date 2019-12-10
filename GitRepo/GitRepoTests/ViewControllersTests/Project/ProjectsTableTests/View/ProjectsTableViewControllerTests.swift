//
//  ProjectsTableViewControllerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: ProjectsTableViewControllerTests
class ProjectsTableViewControllerTests: XCTestCase {
	
	var projectTableView: ProjectsTableViewController!
	var projectsTable: UITableView!
	var projectBase: ProjectsBase!
	

    override func setUp() {
		super.setUp()
		
		projectTableView = ProjectsTableViewController()
		projectsTable = UITableView()
		projectsTable.register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.reusedId)
    }

    override func tearDown() {
		super.tearDown()
		
		projectTableView = nil
		projectsTable = nil
    }
	
	func testCountOfTestsProjects () {
		// arrange
		let countOfProjects: Int?
		// act
		countOfProjects = projectTableView.tableView(projectsTable, numberOfRowsInSection: 0)
		// assert
		XCTAssertEqual(countOfProjects, 0)
	}
	
	func testEditingStyle() {
		// arrange
		// act
		let editingStyle = projectTableView.tableView(projectsTable, editingStyleForRowAt: IndexPath(row: 0, section: 0))
		// assert
		XCTAssertEqual(editingStyle, UITableViewCell.EditingStyle.delete)
	}
	
	func testCountOfProjectsAfterSetProjectBase () {
		// arrange
		let notEmptyProjectBase = ProjectsBase(with: Array(repeating: Project(projectName: "Bar", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: nil, languageOfProject: nil), count: 4))
		let countOfProjects: Int?
		// act
		projectTableView.set(projectsBase: notEmptyProjectBase)
		countOfProjects = projectTableView.tableView(projectsTable, numberOfRowsInSection: 0)
		// assert
		XCTAssertEqual(countOfProjects, 4)
	}

	func testDeleteProject() {
		// arrange
		var countOfProjects: Int
		let notEmptyProjectBase = ProjectsBase(with: Array(repeating: Project(projectName: "Bar", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: nil, languageOfProject: nil), count: 4))
		projectsTable.delegate = projectTableView
		// act
		projectTableView.set(projectsBase: notEmptyProjectBase)
		
		projectTableView.tableView(projectsTable
			, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
		
		countOfProjects = projectTableView.tableView(projectsTable, numberOfRowsInSection: 0)
		
		// assert
		XCTAssertEqual(countOfProjects, 3)
	}
	
	func testNameOfProjectInRow () {
		// arrange
		var testName: String
		let notEmptyProjectBase = ProjectsBase(with: [Project(projectName: "Bar", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: nil, languageOfProject: nil), Project(projectName: "Baz", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: nil, languageOfProject: nil)])
		projectsTable.dataSource = projectTableView
		// act
		projectTableView.set(projectsBase: notEmptyProjectBase)
		let cell = projectTableView.tableView(projectsTable, cellForRowAt: IndexPath(row: 0, section: 0)) as? ProjectTableViewCell
		testName = cell?.project?.projectName ?? ""
		
		// assert
		XCTAssertEqual(testName, "Bar")
	}
	
}
