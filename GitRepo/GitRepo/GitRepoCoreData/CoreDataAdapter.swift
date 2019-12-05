//
//  CoreDataAdapter.swift
//  GitRepo
//
//  Created by Дарья Витер on 05/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataType {
	
	case project
	case repository
	case task
	
	case author
	case branch
	case collaborator
	case commit
}

final class CoreDataAdapter {
	
	func translate(objects: [NSManagedObject]? = nil, oneObject: NSManagedObject? = nil,  dataType: CoreDataType) -> [Any]? {
		switch dataType {
			
		case .repository:
			guard let object = oneObject as? MORepository else { return nil}
			let repository = Repository()
			repository.branchesLink = object.branchesLink
			repository.changes = object.changesLink
			repository.collaboratorsLink = object.collaboratorsLink
			repository.languageOfProject = object.languageOfRepository
			repository.lastChange = object.lastChange
			repository.name = object.name
			repository.owner = User(login: object.owner ?? "")
			repository.repoLink = object.repositoryLink
			return [repository]
			
		case.project:
			guard let object = oneObject as? MOProject else { return nil }
			let project = Project(projectName: object.projectName, repoURL: object.repositoryURL, repo: nil)
			
			return[project]
			
		case .task:
			guard let object = oneObject as? MOTask else { return nil }
			let task = object.taskContent
			
			return [task]
			
		case .author:
			guard let objects = objects as? [MOAuthor] else { return nil }
			var branchesForApp = [User]()
			for object in objects {
				let branchForApp = User(login: object.name)
				branchesForApp.append(branchForApp)
			}
			return branchesForApp
			
		case .branch:
			guard let objects = objects as? [MOBranch] else { return nil }
			var branchesForApp = [Branch]()
			for object in objects {
				let branchForApp = Branch(name: object.name)
				branchesForApp.append(branchForApp)
			}
			return branchesForApp
			
		case .collaborator:
			guard let objects = objects as? [MOCollaborator] else { return nil }
			var branchesForApp = [User]()
			for object in objects {
				let branchForApp = User(login: object.name)
				branchesForApp.append(branchForApp)
			}
			return branchesForApp
			
		case .commit:
			guard let objects = objects as? [MOCommit] else { return nil }
			var branchesForApp = [Commit]()
			for object in objects {
				let branchForApp = Commit(sha: object.sha, message: object.message, author: Commit.Author(name: object.author ?? "", email: nil, date: nil), url: object.url, date: object.date)
				branchesForApp.append(branchForApp)
			}
			return branchesForApp
			
			
		}
	}
	
}
