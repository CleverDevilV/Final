//
//  StartViewPresenterTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: StartViewPresenterTests
class StartViewPresenterTests: XCTestCase {
	
	class SpyView: StartViewProtocol {
		
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
	
	var spyView: SpyView!
	var mockLoader: MockLoader!
	var spyLogOutCommand: SpyLogoutCommand!
	
	var presenter: StartViewPresenterProtocol!
	
	override func setUp() {
		super.setUp()
		
		spyView = SpyView()
		mockLoader = MockLoader()
		spyLogOutCommand = SpyLogoutCommand()
		
		presenter = StartViewPresenter(view: spyView, loader: mockLoader, command: spyLogOutCommand)
	}
	
	override func tearDown() {
		super.tearDown()
		
		spyView = nil
		mockLoader = nil
		presenter = nil
		spyLogOutCommand = nil
	}
	
	func testSetupLoaderFunc () {
		// arrange
		// act
		presenter.setupLoader()
		// assert
		XCTAssertEqual(spyView.logLoader, "setLoader")
		XCTAssertNotNil(spyView.loader)
	}
	
	func testSetupLogCoutCommand () {
		// arrange
		// act
		presenter.setupLogCoutCommand()
		// assert
		XCTAssertEqual(spyView.logLogoutCommand, "setLogoutCommand")
		XCTAssertNotNil(spyView.spyLogoutCommand)
	}
}
