//
//  DescriptionTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: DescriptionTableViewCellTests
class DescriptionTableViewCellTests: XCTestCase {
	
	class SpyDescriptionTableViewCellDelegateClass: DescriptionTableViewCellDelegate {
		
		var log: String?
		
		func projectDescriptionUpdate(_ description: String?) {
			log = description
		}
	}
	
	class SpyDescriptionTableViewCell: DescriptionTableViewCell {
		
		var logDescriptionTableViewCell: String?
		
		override func setupViews() {
			logDescriptionTableViewCell = "setupViews"
		}
	}
	
	var cell: DescriptionTableViewCell!
	var cellDelegate: SpyDescriptionTableViewCellDelegateClass!

    override func setUp() {
		super.setUp()
		
		cell = DescriptionTableViewCell()
		cellDelegate = SpyDescriptionTableViewCellDelegateClass()
		cell.descriptionCellDelegate = cellDelegate
    }

    override func tearDown() {
		super.tearDown()
		
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
		let spyCell = SpyDescriptionTableViewCell()
		// act
		spyCell.setupViews()
		// assert
		XCTAssertEqual(spyCell.logDescriptionTableViewCell, "setupViews")
	}

}
