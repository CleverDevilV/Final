//
//  ProjectModel.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

class Project {
	var projectName: String
	
	var repo: Repo?
	
	init(projectName: String, repo: Repo?) {
		self.projectName = projectName
		self.repo = repo
	}
}
