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
	var settingsViewTable: UITableView!

    override func setUp() {
		settingsView = SettingsViewController()
		settingsViewTable = UITableView()
		settingsViewTable.register(LoginSettingsTableViewCell.self, forCellReuseIdentifier: LoginSettingsTableViewCell.reusedId)
    }

    override func tearDown() {
		settingsView = nil
    }
	
	func testLogOutCommandCall() {
		// arrange
//		 act
//		settingsView.logoutButtonTapped()
		// assert
//		XCTAssertFalse(UserDefaults.standard.isExist(with: UserDefaultsType.oauth_user_login))
//		XCTAssertFalse(UserDefaults.standard.isExist(with: UserDefaultsType.oauth_access_token))
	}
	
	func testCountOfCells() {
		// arrange
		let count: Int?
		// act
		count = settingsView.tableView(settingsViewTable, numberOfRowsInSection: 0)
		// assert
		XCTAssertEqual(count, 2)
	}

}
