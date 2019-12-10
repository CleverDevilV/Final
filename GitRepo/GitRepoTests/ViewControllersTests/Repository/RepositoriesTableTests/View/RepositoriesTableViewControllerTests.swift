//
//  RepositoriesTableViewControllerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: RepositoriesTableViewControllerTests
class RepositoriesTableViewControllerTests: XCTestCase {
	
	class FakeRepositoriesPresenter : RepositoriesPresenterProtocol {
		
		weak var view: RepositoriesTableViewProtocol!
		var testRepositoriesBase: RepositoriesBase!
		
		required init(view: RepositoriesTableViewProtocol, repositoryBase: RepositoriesBase) {
			self.view = view
			self.testRepositoriesBase = repositoryBase
		}
		
		func setRepositoriBase() {
			
			let usersRepository = Repository()
			usersRepository.owner = User(login: "")
			
			testRepositoriesBase = RepositoriesBase(with: [usersRepository])
			
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
		var testCount: Int?
		let testTable = UITableView()
		testTable.register(RepositoriesTableViewCell.self, forCellReuseIdentifier: RepositoriesTableViewCell.repositoriesCellReuseId)
		// act
		presenter.setRepositoriBase()
		testCount = view.tableView(testTable, numberOfRowsInSection: 0)
		// assert
		XCTAssertEqual(testCount, 1)
	}
	
	func testCountOfRepositoriesInSettedBaseIfItMore () {
		// arrange
		var testCount: Int?
		let testTable = UITableView()
		testTable.register(RepositoriesTableViewCell.self, forCellReuseIdentifier: RepositoriesTableViewCell.repositoriesCellReuseId)
		let firstUserRepository = Repository()
		firstUserRepository.owner = User(login: "")
		let secondUserRepository = Repository()
		secondUserRepository.owner = User(login: "")
		let notUsersRepository = Repository()
		notUsersRepository.owner = User(login: "Baz")
		// act
		view.setupRepositoriBase(RepositoriesBase(with: [firstUserRepository, secondUserRepository, notUsersRepository]))
		testCount = view.tableView(testTable, numberOfRowsInSection: 0)
		// assert
		XCTAssertEqual(testCount, 2)
	}

}
