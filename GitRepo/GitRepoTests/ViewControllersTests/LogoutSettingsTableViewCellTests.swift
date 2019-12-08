//
//  LogoutSettingsTableViewCellTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class MockLogoutSettingsTableViewCellDelegate: LogoutSettingsTableViewCellDelegate {

	var logLogoutSettingsTableViewCellDelegate: String?
	
	func logoutButtonTapped() {
		logLogoutSettingsTableViewCellDelegate = "logoutButtonTapped"
	}
}

/// - Tag: LogoutSettingsTableViewCellTests
class LogoutSettingsTableViewCellTests: XCTestCase {
	
	var cell: LogoutSettingsTableViewCell!
	var cellDelegate: MockLogoutSettingsTableViewCellDelegate!

    override func setUp() {
		cell = LogoutSettingsTableViewCell()
		cellDelegate = MockLogoutSettingsTableViewCellDelegate()
		cell.delegate = cellDelegate
    }

    override func tearDown() {
		cell = nil
		cellDelegate = nil
    }
	
	func test () {
		// arrange
		// act
		cell.logoutButtonTapped()
		// assert
		XCTAssertEqual(cellDelegate.logLogoutSettingsTableViewCellDelegate, "logoutButtonTapped")
	}

}
