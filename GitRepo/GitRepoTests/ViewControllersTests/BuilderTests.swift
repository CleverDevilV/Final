//
//  BuilderTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: BuilderTests
class BuilderTests: XCTestCase {
	
	var view: UIViewController!

    override func setUp() {
		super.setUp()
		
		view = UIViewController()
    }

    override func tearDown() {
		super.tearDown()
		
		view = nil
    }
	
//MARK: - StartAppViewController
	func testCreatedStartAppViewControllerIsNotNil () {
		// arrange
		// act
		view = Builder.createStartAppViewController()
		// assert
		XCTAssertNotNil(view)
	}
	
//MARK: - SettingsViewController
	func testCreatedSettingsViewControllerIsNotNil () {
		// arrange
		// act
		view = Builder.createSettingsViewController()
		// assert
		XCTAssertNotNil(view)
	}

//MARK: - SomeWebView
	func testCreatedSomeWebViewIsNotNil () {
		// arrange
		let strForTest = "Bar"
		// act
		view = Builder.createSomeWebView(with: strForTest)
		// assert
		XCTAssertNotNil(view)
	}
	
	func testCreatedSomeWebViewIsNil () {
		// arrange
		let strForTest = ""
		// act
		view = Builder.createSomeWebView(with: strForTest)
		// assert
		XCTAssertNil(view)
	}
	
//MARK: - ProjectsTableView
	func testCreatedProjectsTableViewIsNotNil () {
		// arrange
		// act
		view = Builder.createProjectsTableView()
		// assert
		XCTAssertNotNil(view)
	}
	
//MARK: - ProjectViewController
	func testCreatedProjectViewControllerIsNotNil () {
		// arrange
		let testProject = Project(projectName: "Baz", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: nil, languageOfProject: nil)
		// act
		view = Builder.createProjectViewController(with: testProject)
		// assert
		XCTAssertNotNil(view)
	}
	
	func testCreatedProjectViewControllerIsNil () {
		// arrange
		// act
		view = Builder.createProjectViewController(with: nil)
		// assert
		XCTAssertNil(view)
	}
	
//MARK: - RepositoriesTableViewController
	func testCreatedRepositoriesTableViewControllerIsNotNil () {
		// arrange
		// act
		view = Builder.createRepositoriesTableViewController()
		// assert
		XCTAssertNotNil(view)
	}
	
//MARK: - RepositoryViewController
	func testCreatedRepositoryViewControllerIsNotNil () {
		// arrange
		let testRepository = Repository()
		// act
		view = Builder.createRepositoryViewController(with: testRepository)
		// assert
		XCTAssertNotNil(view)
	}
	
	func testCreatedRepositoryViewControllerIsNil () {
		// arrange
		// act
		view = Builder.createRepositoryViewController(with: nil)
		// assert
		XCTAssertNil(view)
	}
	
//MARK: - CollaboratorsTableView
	func testCreatedCollaboratorsTableViewIsNotNil () {
		// arrange
		let testRepository = Repository()
		// act
		view = Builder.createCollaboratorsTableView(with: testRepository)
		// assert
		XCTAssertNotNil(view)
	}
	
	func testCreatedCollaboratorsTableViewIsNil () {
		// arrange
		// act
		view = Builder.createCollaboratorsTableView(with: nil)
		// assert
		XCTAssertNil(view)
	}
	
	

}
