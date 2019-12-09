//
//  StartViewPresenterTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class StartViewPresenterTests: XCTestCase {
	
	class MockView: StartViewProtocol {
		
		var logLogoutCommand: String?
		var logLoader: String?
		
		var spyLogoutCommand: SpyLogoutCommand?
		var loader: LoaderProtocol?
		
		func setLogoutCommand(command: LogOutCommand?) {
			self.spyLogoutCommand = command as? SpyLogoutCommand
			self.logLogoutCommand = "setLogoutCommand"
		}
		
		func setLoader(loader: LoaderProtocol?) {
			self.loader = loader
			self.logLoader = "setLoader"
		}
	}
	
	var mockView: MockView!
	var mockLoader: MockLoader!
	var spyLogOutCommand: SpyLogoutCommand!
	
	var presenter: StartViewPresenterProtocol!
	
	override func setUp() {
		super.setUp()
		
		mockView = MockView()
		mockLoader = MockLoader()
		spyLogOutCommand = SpyLogoutCommand()
		
		presenter = StartViewPresenter(view: mockView, loader: mockLoader, command: spyLogOutCommand)
	}
	
	override func tearDown() {
		super.tearDown()
		
		mockView = nil
		mockLoader = nil
		presenter = nil
		spyLogOutCommand = nil
	}
	
	func testSetupLoaderFunc () {
		// arrange
		// act
		presenter.setupLoader()
		// assert
		XCTAssertEqual(mockView.logLoader, "setLoader")
		XCTAssertNotNil(mockView.loader)
	}
	
	func testSetupLogCoutCommand () {
		// arrange
		// act
		presenter.setupLogCoutCommand()
		// assert
		XCTAssertEqual(mockView.logLogoutCommand, "setLogoutCommand")
		XCTAssertNotNil(mockView.spyLogoutCommand)
	}
}
