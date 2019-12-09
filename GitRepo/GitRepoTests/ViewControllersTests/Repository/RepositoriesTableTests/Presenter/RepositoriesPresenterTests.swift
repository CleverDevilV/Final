//
//  RepositoriesPresenterTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest

class RepositoriesPresenterTests: XCTestCase {
	
	class SpyView: RepositoriesTableViewProtocol {
		
		var strLog: String?
		var intLog: Int?
		
		func setupRepositoriBase(_ repositoryBase: RepositoriesBase) {
			strLog = "setupRepositoriBase"
			intLog = repositoryBase.repositories.count
		}
	}
	
	var spyView: SpyView!
	var testRepositoriesBase: RepositoriesBase!
	var presenter: RepositoriesPresenter!

    override func setUp() {
		super.setUp()
		
		spyView = SpyView()
		testRepositoriesBase = RepositoriesBase(with: [])
		presenter = RepositoriesPresenter(view: spyView, repositoryBase: testRepositoriesBase)
    }

    override func tearDown() {
		super.tearDown()
		
		spyView = nil
		testRepositoriesBase = nil
		presenter = nil
    }
	
	func testSetRepositoriBaseFunc () {
		// arrange
		// act
		presenter.setRepositoriBase()
		// assert
		XCTAssertEqual(spyView.strLog, "setupRepositoriBase")
		XCTAssertEqual(spyView.intLog, 0)
	}

}
