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

class MockLogoutCommand: LogOutCommand {
	
	var log: String?
	
	override func logOut() {
		log = "log out command"
	}
}

class StartViewPresenterTests: XCTestCase {
	
	class MockLoader: LoaderProtocol {
		var coreDataService: CoreDataServiceProtocol!
		
		func getBaseDataFrom(source: SourceType, endPoint: EndPointType?, baseType: BaseType?, completion: @escaping (Decodable?, String?) -> ()) {
			completion("result", nil)
		}
	}
	
	class MockView: StartViewProtocol {
		
		var logLogoutCommand: String?
		var logLoader: String?
		
		var logoutCommand: MockLogoutCommand?
		var loader: LoaderProtocol?
		
		func setLogoutCommand(command: LogOutCommand?) {
			self.logoutCommand = command as? MockLogoutCommand
			self.logLogoutCommand = "setLogoutCommand"
		}
		
		func setLoader(loader: LoaderProtocol?) {
			self.loader = loader
			self.logLoader = "setLoader"
		}
	}
	
	var view: MockView!
	var loader: MockLoader!
	var logOutCommand: MockLogoutCommand!
	var presenter: StartViewPresenterProtocol!
	
	override func setUp() {
		view = MockView()
		loader = MockLoader()
		logOutCommand = MockLogoutCommand()
		
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
		XCTAssertNotNil(view.logoutCommand)
	}
}
