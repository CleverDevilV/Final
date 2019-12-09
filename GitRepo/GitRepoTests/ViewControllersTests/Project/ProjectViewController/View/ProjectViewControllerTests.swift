//
//  ProjectViewControllerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

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
		
		cell.descriptionCellDelegate = projectView
		// act
		projectView.setupProject(project)
		cell.textViewDidEndEditing(testView)
		// assert
		
		XCTAssertEqual(project.descriptionOfProject, "Bar")
	}
	
}
