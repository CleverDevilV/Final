//
//  ProjectModel.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

final class Project {
	
	public var projectName: String
	public var repoUrl: String?
	
	public var repo: Repository?
	
	init(projectName: String, repoURL: String?, repo: Repository?) {
		self.projectName = projectName
		self.repoUrl = repoURL
		self.repo = repo
	}
}
