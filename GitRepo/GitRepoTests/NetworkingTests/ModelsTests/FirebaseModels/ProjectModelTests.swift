//
//  ProjectModelTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class ProjectModelTests: XCTestCase {
	var project: Project!

    override func setUp() {
		project = Project(projectName: "BaZ", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: "BaRBaZ")
    }

    override func tearDown() {
		project = nil
    }
	
	func testProjectsIsNil() {
		// arrange
		// act
		// assert
		XCTAssertNil(project.projectTasks)
	}
	
	func testAddTaskFunction () {
		// arrange
		// act
		project.addTask("Bar")
		// assert
		XCTAssertNotNil(project.projectTasks)
		XCTAssertEqual(project.projectTasks?.count, 1)
		
		// act
		project.addTask("Baz")
		XCTAssertEqual(project.projectTasks?.count, 2)
	}
	
	func testRemoveTaskFunction () {
		// arrange
		// act
		project.addTask("Bar")
		project.addTask("Baz")
		project.removeTask(at: 0)
		// assert
		
		XCTAssertEqual(project.projectTasks?.count, 1)
		
		// act
		project.removeTask(at: 0)
		// assert
		XCTAssertNil(project.projectTasks)
		
		// act
		project.removeTask(at: 0)
		XCTAssertNil(project.projectTasks)
	}

}
