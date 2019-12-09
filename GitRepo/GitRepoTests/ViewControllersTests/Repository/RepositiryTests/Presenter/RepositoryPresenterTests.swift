//
//  RepositoryPresenterTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: RepositoryPresenterTests
class RepositoryPresenterTests: XCTestCase {
	
	class SpyView: RepositoryViewProtocol {
		
		var log: String?
		
		func setupRepository(_ repository: Repository) {
			log = repository.name
		}
		
		
	}
	
	var spyView: SpyView!
	var testRepository: Repository!
	var presenter: RepositoryPresenter!

    override func setUp() {
		super.setUp()
		
		spyView = SpyView()
		testRepository = Repository()
		presenter = RepositoryPresenter(view: spyView, repository: testRepository)
    }

    override func tearDown() {
		super.tearDown()
		
		spyView = nil
		testRepository = nil
		presenter = nil
    }
	
	func testSetRepositoryFunc () {
		// arrange
		// act
		presenter.setRepository()
		// assert
		XCTAssertEqual(spyView.log, nil)
	}
	
	func testSetRepositoryName () {
		// arrange
		let testRepository = Repository()
		let testPresenter = RepositoryPresenter(view: spyView, repository: testRepository)
		// act
		testRepository.name = "Foo"
		testPresenter.setRepository()
		// assert
		XCTAssertEqual(spyView.log, "Foo")
	}

}
