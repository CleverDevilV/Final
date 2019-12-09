//
//  ProjectViewPresenter.swift
//  GitRepo
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit Tests

protocol ProjectViewProtocol: class {
	func setupProject(_ project: Project)
}

protocol ProjectPresenterProtocol: class {
	init(view: ProjectViewProtocol, project: Project)
	
	func setProject()
}

 /// Unit Tests - [ProjectPresenterTests](x-source-tag://ProjectPresenterTests)
class ProjectPresenter: ProjectPresenterProtocol {
	
	weak var view: ProjectViewProtocol!
	let project: Project!
	
	required init(view: ProjectViewProtocol, project: Project) {
		self.view = view
		self.project = project
	}
	
	func setProject() {
		view.setupProject(project)
	}
}
