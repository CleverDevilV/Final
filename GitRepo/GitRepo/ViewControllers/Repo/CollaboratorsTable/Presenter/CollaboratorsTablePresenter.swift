//
//  CollaboratorsTablePresenter.swift
//  GitRepo
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit Tests

protocol CollaboratorsTableViewProtocol: class {
	func setupRepository(_ repository: Repository)
}

protocol CollaboratorsTablePresenterProtocol: class {
	init(view: CollaboratorsTableViewProtocol, repository: Repository)
	
	func setRepository()
}

 /// Unit Tests - [CollaboratorsTablePresenterTests](x-source-tag://CollaboratorsTablePresenterTests)
class CollaboratorsTablePresenter: CollaboratorsTablePresenterProtocol {
	
	weak var view: CollaboratorsTableViewProtocol!
	let repository: Repository!
	
	required init(view: CollaboratorsTableViewProtocol, repository: Repository) {
		self.view = view
		self.repository = repository
	}
	
	func setRepository() {
		self.view.setupRepository(repository)
	}
}
