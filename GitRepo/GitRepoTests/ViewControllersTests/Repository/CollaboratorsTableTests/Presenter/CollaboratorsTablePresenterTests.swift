//
//  CollaboratorsTablePresenterTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: CollaboratorsTablePresenterTests
class CollaboratorsTablePresenterTests: XCTestCase {
	
	class SpyView: CollaboratorsTableViewProtocol {
		
		var log: String?
		
		func setupRepository(_ repository: Repository) {
			log = repository.name
		}
	}
	
	var spyView: SpyView!
	var presenter: CollaboratorsTablePresenter!
	var testRepository: Repository!

    override func setUp() {
		super.setUp()
		
		spyView = SpyView()
		testRepository = Repository()
		presenter = CollaboratorsTablePresenter(view: spyView, repository: testRepository)
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
		testRepository.name = "Foo"
		presenter.setRepository()
		// assert
		XCTAssertEqual(spyView.log, "Foo")
	}

}
