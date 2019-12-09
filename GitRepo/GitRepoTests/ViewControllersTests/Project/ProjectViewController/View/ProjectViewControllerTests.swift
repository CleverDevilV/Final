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
	
	class MockCellForTestDelegating {
		var descriptionCellDelegate: DescriptionTableViewCellDelegate!
		var repositoryCellDelegate: RepoTableCellDelegate!
		var collaboratorswCellDelegate: CollaboratorsTableViewCellDelegate!
		var tasksCellDelegate: TasksTableViewCellDelegate!
		var viewWithCustomTableCellDelegate: ViewWithCustomTableTableViewCellDelegate!
		
		func descriptionDelegating() {
			descriptionCellDelegate.projectDescriptionUpdate("Bar")
		}
		
		func repositoryDelegating() {
			repositoryCellDelegate.setupRepo()
		}
		
		func collaboratorsDelegating() {
			collaboratorswCellDelegate.addCollaboratorsTable()
		}
		
		func tasksDelegating() {
			tasksCellDelegate.addTasksTable()
		}
		
		func viewDelegating() {
			viewWithCustomTableCellDelegate.addTask()
		}
		
	}
	
	var projectView: ProjectViewController!
	var cell: MockCellForTestDelegating!

    override func setUp() {
		projectView = ProjectViewController()
		cell = MockCellForTestDelegating()
    }

    override func tearDown() {
		projectView = nil
		cell = nil
    }
	
	func testDescriptionDelegating() {
		// arrange
		cell.descriptionCellDelegate = projectView
		// act
		cell.descriptionDelegating()
		// assert
	}
}
