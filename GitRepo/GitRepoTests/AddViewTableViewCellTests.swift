//
//  AddViewTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest

class MockTableView: UITableView {
	
}

class MockAddViewTableViewCell: AddViewTableViewCell {
	
	var testSetupViews: String?
	
	override func setupViews() {
		testSetupViews = "Bar"
	}
	
}


class AddViewTableViewCellTests: XCTestCase {

	var addView: MockAddViewTableViewCell!
	
    override func setUp() {
		addView = MockAddViewTableViewCell()
    }

    override func tearDown() {
		addView = nil
    }
	
	func testCallSetupViewsWhenInit() {
		
		XCTAssertEqual(addView.testSetupViews, "Bar")
	}
	
	func testCallSetupViewsWhenSetArray() {
		
		
		XCTAssertEqual(addView.testSetupViews, "Bar")
	}
	
	func testNoThrowWhenSetupViews() {
		let addView = AddViewTableViewCell()
		addView.arrayOfDataForPresent = ["Bar", "Baz"]
		addView.typeOfData = "Bar"
		XCTAssertNoThrow(addView.setupViews())
		let tableView = UITableView()
		
		
		XCTAssertEqual(addView.tableView(tableView, numberOfRowsInSection: 1), 2)
	}
	

}
