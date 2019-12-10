//
//  AddViewTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: ViewWithCustomTableTableViewCellTests
class ViewWithCustomTableTableViewCellTests: XCTestCase {
	
	class SpyAddViewTableViewCell: ViewWithCustomTableTableViewCell {
		
		var testSetupViews: String?
		
		override func setupViews() {
			testSetupViews = "Bar"
		}
		
	}

	var spyTableView: SpyAddViewTableViewCell!
	var defaultAddView: ViewWithCustomTableTableViewCell!
	
	var tableView: UITableView!

	
    override func setUp() {
		super.setUp()
		
//		spyTableView = SpyAddViewTableViewCell()
		defaultAddView = ViewWithCustomTableTableViewCell()
		
		tableView = UITableView()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func tearDown() {
		super.tearDown()
		
		spyTableView = nil
    }
	
	func testCallSetupViewsWhenInit() {
		// arrange
		let spyTableView = SpyAddViewTableViewCell()
		// act
		spyTableView.setupViews()
		// assert
		XCTAssertEqual(spyTableView.testSetupViews, "Bar")
	}
	
	func testCallSetupViewsWhenSetArray() {
		// arrange
		let spyTableView = SpyAddViewTableViewCell()
		// act
		spyTableView.arrayOfDataForPresent = ["Baz"]
		// assert
		XCTAssertEqual(spyTableView.testSetupViews, "Bar")
	}
	
	func testCorrectNumberOfRowsInTable() {
		// arrage
		var numberOfRows: Int?
		// act
		defaultAddView.arrayOfDataForPresent = ["Bar", "Baz"]
		numberOfRows = defaultAddView.tableView(tableView, numberOfRowsInSection: 1)
		// assert
		XCTAssertEqual(numberOfRows, 2)
	}
	
	func testTypeOfCellInTableWithTypeOfDataTask () {
		// arrage
		var cell: UITableViewCell
		var text: String?
		// act
		defaultAddView.arrayOfDataForPresent = ["Bar", "Baz"]
		defaultAddView.typeOfData = .tasks
		cell = defaultAddView.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
		text = cell.textLabel?.text
		// assert
		XCTAssertEqual(text, "Bar")
	}
	
	func testTypeOfCellInTableWithTypeOfDataCollaborators () {
		// arrage
		let addView = ViewWithCustomTableTableViewCell()
		var cell: UITableViewCell
		var text: String?
		// act
		addView.arrayOfDataForPresent = [User(login: "Bar"), User(login: "Baz")]
		addView.typeOfData = .collaborators
		cell = addView.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0))
		text = cell.textLabel?.text
		// assert
		XCTAssertEqual(text, "Baz")
	}
	
	func testHeaderHeightIsNotNil() {
		// arrage
		var headerHeight: CGFloat
		// act
		defaultAddView.typeOfData = .tasks
		headerHeight = defaultAddView.tableView(tableView, heightForHeaderInSection: 0)
		// assert
		XCTAssertEqual(headerHeight, 50)
	}
	
	func testHeaderViewIsNotNil() {
		// arrage
		var headerView: UIView?
		// act
		defaultAddView.typeOfData = .tasks
		headerView = defaultAddView.tableView(tableView, viewForHeaderInSection: 0)
		// assert
		XCTAssertNotNil(headerView)
	}
	
	func testHeaderHeightIsZero() {
		// arrage
		var headerHeight: CGFloat
		// act
		defaultAddView.typeOfData = .collaborators
		headerHeight = defaultAddView.tableView(tableView, heightForHeaderInSection: 0)
		// assert
		XCTAssertEqual(headerHeight, 0)
	}
	
	func testHeaderViewIsNil() {
		// arrange
		var headerView: UIView?
		// act
		headerView = defaultAddView.tableView(tableView, viewForHeaderInSection: 0)
		// assert
		XCTAssertNil(headerView)
	}
	
	func testEditingStyleDelete() {
		// arrage
		var editingStyle: UITableViewCell.EditingStyle
		// act
		defaultAddView.typeOfData = .tasks
		editingStyle = defaultAddView.tableView(tableView, editingStyleForRowAt: IndexPath(row: 0, section: 1))
		// assert
		XCTAssertEqual(editingStyle, UITableViewCell.EditingStyle.delete)
	}
	
	func testEditingStyleNone() {
		// arrage
		var editingStyle: UITableViewCell.EditingStyle
		// act
		defaultAddView.typeOfData = .collaborators
		editingStyle = defaultAddView.tableView(tableView, editingStyleForRowAt: IndexPath(row: 0, section: 1))
		// assert
		XCTAssertEqual(editingStyle, UITableViewCell.EditingStyle.none)
	}
	
	func testCenEditRowTrue() {
		// arrage
		var canEdit: Bool
		// act
		defaultAddView.typeOfData = .tasks
		canEdit = defaultAddView.tableView(tableView, canEditRowAt: IndexPath(row: 0, section: 1))
		// assert
		XCTAssertTrue(canEdit)
	}
	
	func testCenEditRowFalse() {
		// arrage
		var canEdit: Bool
		// act
		defaultAddView.typeOfData = .collaborators
		canEdit = defaultAddView.tableView(tableView, canEditRowAt: IndexPath(row: 0, section: 1))
		// assert
		XCTAssertFalse(canEdit)
	}
}
