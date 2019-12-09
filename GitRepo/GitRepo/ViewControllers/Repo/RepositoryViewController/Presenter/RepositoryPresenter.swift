//
//  RepositoryPresenter.swift
//  GitRepo
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

protocol RepositoryViewProtocol: class {
	func setupRepository(_ repository: Repository)
}

protocol RepositoryPresenterProtocol: class {
	
	init(view: RepositoryViewProtocol, repository: Repository)
	
	func setRepository()
}

class RepositoryPresenter: RepositoryPresenterProtocol {
	
	weak var view: RepositoryViewProtocol!
	let repository: Repository!
	
	required init(view: RepositoryViewProtocol, repository: Repository) {
		self.view = view
		self.repository = repository
	}
	
	func setRepository() {
		view.setupRepository(repository)
	}
	
}
