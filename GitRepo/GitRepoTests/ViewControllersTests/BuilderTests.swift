//
//  BuilderTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class BuilderTests: XCTestCase {

    override func setUp() {
		super.setUp()
		
    }

    override func tearDown() {
		super.tearDown()
		
    }
	
	func testCreatedStartAppViewControllerIsNotNil () {
		// arrange
		var view = UIViewController()
		// act
		view = Builder.createStartAppViewController()
		// assert
		XCTAssertNotNil(view)
	}
	
	func testCreatedSettingsViewControllerIsNotNil () {
		// arrange
		var view = UIViewController()
		// act
		view = Builder.createSettingsViewController()
		// assert
		XCTAssertNotNil(view)
	}
	
	func testCreatedSomeWebViewIsNotNil () {
		// arrange
		var view: UIViewController?
		let strForTest = "Bar"
		// act
		view = Builder.createSomeWebView(with: strForTest)
		// assert
		XCTAssertNotNil(view)
	}
	
	func testCreatedSomeWebViewIsNil () {
		// arrange
		var view: UIViewController?
		let strForTest = ""
		// act
		view = Builder.createSomeWebView(with: strForTest)
		// assert
		XCTAssertNil(view)
	}
	
	func testCreatedProjectsTableViewIsNotNil () {
		// arrange
		var view: UIViewController?
		// act
		view = Builder.createProjectsTableView()
		// assert
		XCTAssertNotNil(view)
	}
	
	func testCreatedProjectViewControllerIsNotNil () {
		// arrange
		var view: UIViewController?
		let testProject = Project(projectName: "Baz", repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: nil, languageOfProject: nil)
		// act
		view = Builder.createProjectViewController(with: testProject)
		// assert
		XCTAssertNotNil(view)
	}
	
	func testCreatedProjectViewControllerIsNil () {
		// arrange
		var view: UIViewController?
		// act
		view = Builder.createProjectViewController(with: nil)
		// assert
		XCTAssertNil(view)
	}

}
