//
//  SegmentCommitsBranchesTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: SegmentCommitsBranchesTableViewCellTests
class SegmentCommitsBranchesTableViewCellTests: XCTestCase {
	
	class MockSegmentCommitsBranchesTableViewCellDelegate: SegmentCommitsBranchesTableViewCellDelegate {
		
		var logIndexPath: IndexPath?
		var logInt: Int?
		
		func setSegmentControllerValue(_ value: Int) {
			logInt = value
		}
		
		func showWebView(at indexPath: IndexPath) {
			logIndexPath = indexPath
		}
	}

	var cell: SegmentCommitsBranchesTableViewCell!
	var cellDelegate: MockSegmentCommitsBranchesTableViewCellDelegate!
	
    override func setUp() {
		cell = SegmentCommitsBranchesTableViewCell()
		cellDelegate = MockSegmentCommitsBranchesTableViewCellDelegate()
		cell.delegate = cellDelegate
    }

    override func tearDown() {
		cell = nil
		cellDelegate = nil
    }
	
	func testCellIsNotNil(){
		// arrange
		let mockTableView = UITableView()
		mockTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		var mockCell: UITableViewCell!
		// act
		mockCell = cell.tableView(mockTableView, cellForRowAt: IndexPath(row: 1, section: 1))
		// assert
		XCTAssertNotNil(mockCell)
	}
	
	func testSegmentValueChangedFunc () {
		// arrange
		// act
		cell.segmentValueChanged()
		// assert
		XCTAssertEqual(cellDelegate.logInt, 0)
	}
	
	func testShowWebViewWithDelegate () {
		// arrange
		let mockTableView = UITableView()
		mockTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		// act
		cell.tableView(mockTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
		// assert
		XCTAssertEqual(cellDelegate.logIndexPath, IndexPath(row: 0, section: 0))
	}

}
