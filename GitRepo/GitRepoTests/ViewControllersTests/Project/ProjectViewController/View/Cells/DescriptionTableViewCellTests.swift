//
//  DescriptionTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo


class MockDescriptionTableViewCellDelegateClass: DescriptionTableViewCellDelegate {
	
	var log: String?
	
	func projectDescriptionUpdate(_ description: String?) {
		log = description
	}
}

class MockDescriptionTableViewCell: DescriptionTableViewCell {
	
	var logDescriptionTableViewCell: String?
	
	override func setupViews() {
		logDescriptionTableViewCell = "setupViews"
	}
}

/// - Tag: DescriptionTableViewCellTests
class DescriptionTableViewCellTests: XCTestCase {
	
	var cell: DescriptionTableViewCell!
	var cellDelegate: MockDescriptionTableViewCellDelegateClass!

    override func setUp() {
		cell = DescriptionTableViewCell()
		cellDelegate = MockDescriptionTableViewCellDelegateClass()
		cell.descriptionCellDelegate = cellDelegate
    }

    override func tearDown() {
		cell = nil
		cellDelegate = nil
    }
	
	func testTextViewDidEndEditingFuncWithDelegate () {
		// arrange
		let textView = UITextView()
		// act
		textView.text = "Bar"
		cell.textViewDidEndEditing(textView)
		// assert
		XCTAssertEqual(cellDelegate.log, "Bar")
	}
	
	func testSetupViews() {
		// arrange
		let mockCell = MockDescriptionTableViewCell()
		// act
		// assert
		XCTAssertEqual(mockCell.logDescriptionTableViewCell, "setupViews")
	}

}
