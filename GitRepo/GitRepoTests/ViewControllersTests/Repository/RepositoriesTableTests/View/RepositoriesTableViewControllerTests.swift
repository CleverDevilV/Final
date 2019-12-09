//
//  RepositoriesTableViewControllerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class RepositoriesTableViewControllerTests: XCTestCase {
	
	class FakeRepositoriesPresenter : RepositoriesPresenterProtocol {
		
		weak var view: RepositoriesTableViewProtocol!
		var testRepositoriesBase: RepositoriesBase!
		
		required init(view: RepositoriesTableViewProtocol, repositoryBase: RepositoriesBase) {
			self.view = view
			self.testRepositoriesBase = repositoryBase
		}
		
		func setRepositoriBase() {
			view.setupRepositoriBase(testRepositoriesBase)
		}
	}
	
	var view: RepositoriesTableViewController!
	var presenter: FakeRepositoriesPresenter!
	var testRepositoriesBase: RepositoriesBase!

    override func setUp() {
		super.setUp()
		
		view = RepositoriesTableViewController()
		testRepositoriesBase = RepositoriesBase(with: [])
		presenter = FakeRepositoriesPresenter(view: view, repositoryBase: testRepositoriesBase)
    }

    override func tearDown() {
		super.tearDown()
		
		view = nil
		testRepositoriesBase = nil
		presenter = nil
    }
	
	func testCountOfRepositoriesInSettedBase () {
		// arrange
		let testTable = UITableView()
		testTable.register(RepositoriesTableViewCell.self, forCellReuseIdentifier: RepositoriesTableViewCell.repositoriesCellReuseId)
		// act
		presenter.setRepositoriBase()
		// assert
		
		let testCount = view.tableView(testTable, numberOfRowsInSection: 0)
		
		XCTAssertEqual(testCount, 0)
	}

}
