//
//  ProjectsTablePresenter.swift
//  GitRepo
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit Tests

protocol ProjectsTableViewProtocol: class {
	func set(projectsBase: ProjectsBase)
}

protocol ProjectsTablePresenterProtocol: class {
	init(view: ProjectsTableViewProtocol?, projectsBase: ProjectsBase)
	
	func setProjectsBase()
}

class ProjectsTablePresenter: ProjectsTablePresenterProtocol {
	
	weak var view: ProjectsTableViewProtocol?
	let projectsBase: ProjectsBase!
	
	required init(view: ProjectsTableViewProtocol?, projectsBase: ProjectsBase) {
		self.view = view
		self.projectsBase = projectsBase
	}
	
	func setProjectsBase() {
		view?.set(projectsBase: projectsBase)
	}
}
