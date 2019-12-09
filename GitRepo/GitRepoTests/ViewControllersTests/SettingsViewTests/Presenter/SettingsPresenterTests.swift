//
//  SettingsPresenterTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class SettingsPresenterTests: XCTestCase {
	
	class MockView: SettingsViewProtocol {
		
		var spyLogoutCommand: SpyLogoutCommand?
		var log: String?
		
		func setupLogoutCommang(_ command: LogOutCommand) {
			self.spyLogoutCommand = command as? SpyLogoutCommand
			self.log = "setLogoutCommand"
		}
		
		
	}
	
	var mockView: MockView!
	var spyLogOutCommand: SpyLogoutCommand!
	
	var presenter: SettingsPresenter!

    override func setUp() {
		super.setUp()
		
		mockView = MockView()
		spyLogOutCommand = SpyLogoutCommand()
		presenter = SettingsPresenter(view: mockView, command: spyLogOutCommand)
    }

    override func tearDown() {
		super.tearDown()
		
		mockView = nil
		spyLogOutCommand = nil
    }
	
	func testSetupLogCoutCommandFunc () {
		// arrange
		// act
		presenter.setCommand()
		// assert
		XCTAssertEqual(mockView.log, "setLogoutCommand")
		XCTAssertNotNil(mockView.spyLogoutCommand)
	}
	
	func testFailSetCommandFunc() {
		// arrange
		
		let nilCommandPresenter = SettingsPresenter(view: mockView, command: nil)
		// act
		nilCommandPresenter.setCommand()
		// assert
//		???
	}

}
