//
//  StartViewPresenterTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest

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
	
	var view: MockView!
	var loader: MockLoader!
	var logOutCommand: SpyLogoutCommand!
	var presenter: StartViewPresenterProtocol!
	
	override func setUp() {
		view = MockView()
		loader = MockLoader()
		logOutCommand = SpyLogoutCommand()
		
		presenter = StartViewPresenter(view: view, loader: loader, command: logOutCommand)
	}
	
	override func tearDown() {
		view = nil
		loader = nil
		presenter = nil
		logOutCommand = nil
	}
	
	func testSetupLoaderFunc () {
		// arrange
		// act
		presenter.setupLoader()
		// assert
		XCTAssertEqual(view.logLoader, "setLoader")
		XCTAssertNotNil(view.loader)
	}
	
	func testSetupLogCoutCommand () {
		// arrange
		// act
		presenter.setupLogCoutCommand()
		// assert
		XCTAssertEqual(view.logLogoutCommand, "setLogoutCommand")
		XCTAssertNotNil(view.spyLogoutCommand)
	}
}
