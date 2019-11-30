
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
	
//	func setHttpUrl(_ url: String) {
//		self.html_url = url
//		print("set html_url: ", self.html_url)
//	}
	
}
