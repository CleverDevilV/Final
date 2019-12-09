//
//  ProjectPresenterTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class ProjectPresenterTests: XCTestCase {
	
	class SpyView: ProjectViewProtocol {
		
		var log: String?
		
		func setupProject(_ project: Project) {
			log = project.projectName
		}
	}
	
	var spyView: SpyView!
	var presenter: ProjectPresenter!
	var testProject: Project!

    override func setUp() {
		super.setUp()
		
		spyView = SpyView()
		testProject = Project(projectName: "Baz", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: nil, languageOfProject: nil)
		
		presenter = ProjectPresenter(view: spyView, project: testProject)
		
    }

    override func tearDown() {
		super.tearDown()
		
		spyView = nil
		testProject = nil
    }
	
	func testSetProject () {
		// arrange
		// act
		presenter.setProject()
		// assert
		XCTAssertEqual(spyView.log, "Baz")
	}

}
