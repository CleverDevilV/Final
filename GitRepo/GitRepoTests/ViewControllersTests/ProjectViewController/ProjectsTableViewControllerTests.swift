//
//  ProjectsTableViewControllerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class ProjectsTableViewControllerTests: XCTestCase {
	
	var projectTableView: ProjectsTableViewController!
	var projectsTable: UITableView!

    override func setUp() {
		projectTableView = ProjectsTableViewController()
		projectsTable = UITableView()
		projectsTable.register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.reusedId)
    }

    override func tearDown() {
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

}
