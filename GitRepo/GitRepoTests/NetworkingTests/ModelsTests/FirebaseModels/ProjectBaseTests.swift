//
//  ProjectBaseTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: ProjectBaseTests
class ProjectBaseTests: XCTestCase {
	
	var project: Project!
	var projects: [Project]!
	var projectBase: ProjectsBase!
	var strData: String?

    override func setUp() {
		
		project = Project(projectName: "BaZ", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: "BaRBaZ")
		projects = Array.init(repeating: project, count: 3)
		projectBase = ProjectsBase(with: projects)
		
		strData = """
		[
			{
			"descriptionOfProject": "Baz",
			"name": "Bar",
			"projectTasks": [
			"1"
			],
			"repoUrl": "https://github.com/CleverDevilV/Test",
			"repositoryName": "Foo"
			}
			]
"""
    }


    override func tearDown() {
		project = nil
		projects = nil
		projectBase = nil
		strData = nil
    }
	
	func testAddProjectFunc() {
		// arrange
		// act
		projectBase.addProject(project)
		// assert
		XCTAssertEqual(projectBase.projects.count, 4)
	}
	
	func testRemoveProjectFunc() {
		// arrange
		// act
		projectBase.removeProject(atIndex: 0)
		// assert
		XCTAssertEqual(projectBase.projects.count, 2)
	}
	
	func testCreateProjectsFromDecode() {
		// arrange
		let data = strData?.data(using: .utf8)
		// act
		do {
			let newResponse = try JSONDecoder().decode([Project].self, from: data!)
			print(newResponse)
			// assert
			XCTAssertNotNil(newResponse)
		} catch {
			print(error)
		}
	}

}
