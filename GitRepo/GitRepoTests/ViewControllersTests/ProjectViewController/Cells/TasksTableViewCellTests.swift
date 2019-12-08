//
//  TasksTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: TasksTableViewCellTests
class TasksTableViewCellTests: XCTestCase {
	
	class MockTasksTableViewCellDelegate: TasksTableViewCellDelegate {
		
		var logMockTasksTableViewCellDelegate: String?
		
		func addTasksTable() {
			logMockTasksTableViewCellDelegate = "addTasksTable"
		}
		
		
	}

	var cell: TasksTableViewCell!
	var cellDelegate: MockTasksTableViewCellDelegate!
	
	
    override func setUp() {
		cell = TasksTableViewCell()
		cellDelegate = MockTasksTableViewCellDelegate()
		cell.delegate = cellDelegate
    }

    override func tearDown() {
		cell = nil
		cellDelegate = nil
		
    }
	
	func testTapTasksButtonWithDelegate() {
		// arrange
		// act
		cell.tapTasksButton()
		// assert
		XCTAssertEqual(cellDelegate.logMockTasksTableViewCellDelegate, "addTasksTable")
	}

}
