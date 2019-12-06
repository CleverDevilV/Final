
//
//  RepoModel.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class Repo {
	var name: String
	var repoLink: String?
	var collaborators: [String]
	var changes: [String:Date]
	var languageOfProject: String?
	var owner: String
	
	init(name: String, repoLink: String?, languageOfProject: String? = nil, collaborators: [String], changes: [String:Date], owner: String) {
		self.name = name
		self.repoLink = repoLink
		self.collaborators = collaborators
		
		self.languageOfProject = languageOfProject
		self.changes = changes
		self.owner = owner
	}
	
	static func decodeDataFromBack(inputData: [RepoFromGit]) -> [Repo] {
		var repos = [Repo]()
		for repoFromBack in inputData {
			let repo = Repo(name: repoFromBack.name, repoLink: repoFromBack.html_url, languageOfProject: repoFromBack.language, collaborators: [], changes: [:], owner: repoFromBack.owner.login)
			repos.append(repo)
		}
		return repos
	}	
}

struct Login: Codable {
	var login: String
}
