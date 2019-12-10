//
//  ProjectModelTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: ProjectModelTests
class ProjectModelTests: XCTestCase {
	var project: Project!

    override func setUp() {
		super.setUp()
		
		project = Project(projectName: "BaZ", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: "BaRBaZ", languageOfProject: nil)
    }

    override func tearDown() {
		super.tearDown()
		
		project = nil
    }
	
	func testProjectsIsNil() {
		// arrange
		// act
		project.projectTasks = nil
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
		// assert
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
		// assert
		XCTAssertNil(project.projectTasks)
	}
	
	func testSetRepository() {
		// arrange
		let testRepository = Repository()
		testRepository.name = "Foo"
		
		var testProject: Project? = Project(projectName: "Bar", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: nil, languageOfProject: nil)
		// act
		Project.setRepository(testRepository, to: &testProject)
		// assert
		XCTAssertNotNil(testProject?.repo)
		XCTAssertEqual(testProject?.repositoryName, "Foo")
	}
	
	func testFailSetRepository() {
		// arrange
		let testRepository = Repository()
		testRepository.name = "Foo"
		
		var testProject: Project? = nil
		// act
		Project.setRepository(testRepository, to: &testProject)
		// assert
		XCTAssertNil(testProject?.repo)
		XCTAssertNotEqual(testProject?.repositoryName, "Foo")
	}

}
