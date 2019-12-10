//
//  SomeWebPresenterTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: SomeWebPresenterTests
class SomeWebPresenterTests: XCTestCase {
	
	class SpyView: SomeWebViewProtocol {
		
		var logURL: URL?
		
		func setURL(_ url: URL) {
			logURL = url
		}
	}
	
	var spyView: SpyView!
	var presenter: SomeWebPresenter!

    override func setUp() {
		super.setUp()
		
		spyView = SpyView()
		presenter = SomeWebPresenter(view: spyView, path: "BarBazURL")
    }

    override func tearDown() {
		super.tearDown()
		
		spyView = nil
    }
	
	func testSetURL () {
		// arrange
		let testsURL = URL(string: "BarBazURL")
		// act
		presenter.setURL()
		// assert
		XCTAssertEqual(spyView.logURL, testsURL)
	}
	
	func testSetURLWithNilPath () {
		// arrange
		let testPresenter = SomeWebPresenter(view: spyView, path: nil)
		// act
		testPresenter.setURL()
		// assert
		XCTAssertNil(spyView.logURL)
	}

	func testSetURLWithNotNilPathButNilURL () {
		// arrange
		let testPresenter = SomeWebPresenter(view: spyView, path: "")
		// act
		testPresenter.setURL()
		// assert
		XCTAssertNil(spyView.logURL)
	}
}
