//
//  SettingsViewControllerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: SettingsViewControllerTests
class SettingsViewControllerTests: XCTestCase {
	
	var settingsView: SettingsViewController!
	var spyLogoutCommand: SpyLogoutCommand!
	var settingsViewTable: UITableView!

    override func setUp() {
		super.setUp()
		
		settingsView = SettingsViewController()
		settingsViewTable = UITableView()
		settingsViewTable.register(LoginSettingsTableViewCell.self, forCellReuseIdentifier: LoginSettingsTableViewCell.reusedId)
		
		spyLogoutCommand = SpyLogoutCommand()
    }

    override func tearDown() {
		super.tearDown()
		
		settingsView = nil
		spyLogoutCommand = nil
		settingsViewTable = nil
    }
	
	func testLogoutButtonTappedFunc () {
		// arrange
		// act
		settingsView.setupLogoutCommang(spyLogoutCommand)
		settingsView.logoutButtonTapped()
		
		// assert
		XCTAssertEqual(spyLogoutCommand.log, "log out command")
		
		XCTAssertFalse(UserDefaults.standard.isExist(with: UserDefaultsType.oauth_user_login))
		XCTAssertFalse(UserDefaults.standard.isExist(with: UserDefaultsType.oauth_access_token))
	}
	
	func testCountOfCells () {
		// arrange
		let count: Int?
		// act
		count = settingsView.tableView(settingsViewTable, numberOfRowsInSection: 0)
		// assert
		XCTAssertEqual(count, 2)
	}
	
	func testTapOnCellWithLogoutButton () {
		// arrange
		// act
		settingsView.setupLogoutCommang(spyLogoutCommand)
		settingsView.tableView(settingsViewTable, didSelectRowAt: IndexPath(row: 1, section: 0))
		// assert
		XCTAssertEqual(spyLogoutCommand.log, "log out command")
	}

}
