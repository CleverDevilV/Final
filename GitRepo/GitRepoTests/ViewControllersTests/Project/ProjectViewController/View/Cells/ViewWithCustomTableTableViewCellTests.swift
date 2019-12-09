//
//  AddViewTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo


class MockTableView: UITableView {
	
}

class MockAddViewTableViewCell: ViewWithCustomTableTableViewCell {
	
	var testSetupViews: String?
	
	override func setupViews() {
		testSetupViews = "Bar"
	}
	
}

/// - Tag: MockTableView
class ViewWithCustomTableTableViewCellTests: XCTestCase {

	var mockAddView: MockAddViewTableViewCell!
	var defaultAddView: ViewWithCustomTableTableViewCell!
	
	var tableView: UITableView!

	
    override func setUp() {
		mockAddView = MockAddViewTableViewCell()
		defaultAddView = ViewWithCustomTableTableViewCell()
		
		tableView = UITableView()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func tearDown() {
		mockAddView = nil
    }
	
	func testCallSetupViewsWhenInit() {
		
		XCTAssertEqual(mockAddView.testSetupViews, "Bar")
	}
	
	func testCallSetupViewsWhenSetArray() {
		
		
		XCTAssertEqual(mockAddView.testSetupViews, "Bar")
	}
	
	func testNoThrowWhenSetupViews() {
		defaultAddView.typeOfData = .none
		XCTAssertNoThrow(defaultAddView.setupViews())
	}
	
	func testCorrectNumberOfRowsInTable() {
		
		defaultAddView.arrayOfDataForPresent = ["Bar", "Baz"]
		
		XCTAssertEqual(defaultAddView.tableView(tableView, numberOfRowsInSection: 1), 2)
	}
	
	func testTypeOfCellInTableWithTypeOfDataTask () {
		defaultAddView.arrayOfDataForPresent = ["Bar", "Baz"]
		defaultAddView.typeOfData = .tasks
		let cell = defaultAddView.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
		let text = cell.textLabel?.text
		
		
		XCTAssertEqual(text, "Bar")
	}
	
	func testTypeOfCellInTableWithTypeOfDataCollaborators () {
		let addView = ViewWithCustomTableTableViewCell()
		addView.arrayOfDataForPresent = [User(login: "Bar"), User(login: "Baz")]
		addView.typeOfData = .collaborators
		let cell = addView.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0))
		let text = cell.textLabel?.text
		
		
		XCTAssertEqual(text, "Baz")
	}
	
	func testHeaderIsNotNil() {
		defaultAddView.typeOfData = .tasks
		let headerHeight = defaultAddView.tableView(tableView, heightForHeaderInSection: 0)
		XCTAssertEqual(headerHeight, 50)
		
		let headerView = defaultAddView.tableView(tableView, viewForHeaderInSection: 0)
		XCTAssertNotNil(headerView)
		
	}
	
	func testHeaderIsNil() {
		
		defaultAddView.typeOfData = .collaborators
		let headerHeight = defaultAddView.tableView(tableView, heightForHeaderInSection: 0)
		XCTAssertEqual(headerHeight, 0)
		
		let headerView = defaultAddView.tableView(tableView, viewForHeaderInSection: 0)
		XCTAssertNil(headerView)
		
		defaultAddView.typeOfData = .none
		XCTAssertNil(defaultAddView.tableView(tableView, viewForHeaderInSection: 0))
		XCTAssertEqual(defaultAddView.tableView(tableView, heightForHeaderInSection: 0), 0)
	}
	
	func testEditingStyleDelete() {
		defaultAddView.typeOfData = .tasks
		let editingStyle = defaultAddView.tableView(tableView, editingStyleForRowAt: IndexPath(row: 0, section: 1))
		
		XCTAssertEqual(editingStyle, UITableViewCell.EditingStyle.delete)
	}
	
	func testEditingStyleNone() {
		defaultAddView.typeOfData = .collaborators
		let editingStyle = defaultAddView.tableView(tableView, editingStyleForRowAt: IndexPath(row: 0, section: 1))
		XCTAssertEqual(editingStyle, UITableViewCell.EditingStyle.none)
		
		defaultAddView.typeOfData = .none
		XCTAssertEqual(defaultAddView.tableView(tableView, editingStyleForRowAt: IndexPath(row: 0, section: 1)), UITableViewCell.EditingStyle.none)
	}
	
	func testCenEditRowTrue() {
		defaultAddView.typeOfData = .tasks
		
		let canEdit = defaultAddView.tableView(tableView, canEditRowAt: IndexPath(row: 0, section: 1))
		
		XCTAssertTrue(canEdit)
	}
	
	func testCenEditRowFalse() {
		defaultAddView.typeOfData = .collaborators
		
		let canEdit = defaultAddView.tableView(tableView, canEditRowAt: IndexPath(row: 0, section: 1))
		
		XCTAssertFalse(canEdit)
		
		defaultAddView.typeOfData = .none
		XCTAssertFalse(defaultAddView.tableView(tableView, canEditRowAt: IndexPath(row: 0, section: 1)))
	}
	
	func testEdditingStyle() {
		
		XCTAssertNoThrow(defaultAddView.tableView(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0)))
	}
	

}
