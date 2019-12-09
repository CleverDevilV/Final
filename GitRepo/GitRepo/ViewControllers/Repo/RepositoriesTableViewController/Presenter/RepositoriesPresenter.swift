//
//  RepositoriesPresenter.swift
//  GitRepo
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

protocol RepositoriesTableViewProtocol: class {
	func setupRepositoriBase(_ repositoryBase: RepositoriesBase)
}

protocol RepositoriesPresenterProtocol: class {
	init(view: RepositoriesTableViewProtocol, repositoryBase: RepositoriesBase)
	
	func setRepositoriBase()
}

class RepositoriesPresenter: RepositoriesPresenterProtocol {
	
	weak var view: RepositoriesTableViewProtocol!
	let repositoryBase: RepositoriesBase!
	
	required init(view: RepositoriesTableViewProtocol, repositoryBase: RepositoriesBase) {
		self.view = view
		self.repositoryBase = repositoryBase
	}
	
	func setRepositoriBase() {
		view.setupRepositoriBase(repositoryBase)
	}
}
