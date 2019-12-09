//
//  ProjectsTablePresenterTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class ProjectsTablePresenterTests: XCTestCase {
	
	class SpyView: ProjectsTableViewProtocol {
		
		var log: String?
		var countOfProjects: Int?
		
		func set(projectsBase: ProjectsBase) {
			log = "set projectsBase"
			countOfProjects = projectsBase.projects.count
		}
	}

	var spyView: SpyView?
	var presenter: ProjectsTablePresenter?
	
    override func setUp() {
		super.setUp()
		
		spyView = SpyView()
		presenter = ProjectsTablePresenter(view: spyView, projectsBase: ProjectsBase(with: []))
    }

    override func tearDown() {
		super.tearDown()
		
		spyView = nil
		presenter = nil
    }
	
	func testSetProjectBaseFunc () {
		// arrange
		// act
		presenter?.setProjectsBase()
		// assert
		XCTAssertEqual(spyView?.log, "set projectsBase")
		XCTAssertEqual(spyView?.countOfProjects, 0)
	}
	
	func testCountOfProjectsInSetProjectBase() {
		// arrange
		let notEmptyProjectBase = ProjectsBase(with: Array(repeating: Project(projectName: "Bar", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: nil, languageOfProject: nil), count: 4))
		
		let testedPresenter = ProjectsTablePresenter(view: spyView, projectsBase: notEmptyProjectBase)
		// act
		testedPresenter.setProjectsBase()
		// assert
		XCTAssertEqual(spyView?.log, "set projectsBase")
		XCTAssertEqual(spyView?.countOfProjects, 4)
	}

}
