//
//  SettingsPresenterTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: SettingsPresenterTests
class SettingsPresenterTests: XCTestCase {
	
	class SpyView: SettingsViewProtocol {
		
		var spyLogoutCommand: SpyLogoutCommand?
		var log: String?
		
		func setupLogoutCommang(_ command: LogOutCommand) {
			self.spyLogoutCommand = command as? SpyLogoutCommand
			self.log = "setLogoutCommand"
		}
	}
	
	var spyView: SpyView!
	var spyLogOutCommand: SpyLogoutCommand!
	
	var presenter: SettingsPresenter!

    override func setUp() {
		super.setUp()
		
		spyView = SpyView()
		spyLogOutCommand = SpyLogoutCommand()
		presenter = SettingsPresenter(view: spyView, command: spyLogOutCommand)
    }

    override func tearDown() {
		super.tearDown()
		
		spyView = nil
		spyLogOutCommand = nil
    }
	
	func testSetupLogCoutCommandFunc () {
		// arrange
		// act
		presenter.setCommand()
		// assert
		XCTAssertEqual(spyView.log, "setLogoutCommand")
		XCTAssertNotNil(spyView.spyLogoutCommand)
	}
	
	func testFailSetCommandFunc() {
		// arrange
		let nilCommandPresenter = SettingsPresenter(view: spyView, command: nil)
		// act
		nilCommandPresenter.setCommand()
		// assert
		XCTAssertNil(spyView.log)
	}

}
