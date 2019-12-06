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

protocol CoreDataAdapterProtocol {
	
	func translate(objects: [NSManagedObject]?, oneObject: NSManagedObject?,  dataType: CoreDataType) -> [Any]?
	func translateData(_ data: Any?, arrayOfData: [Any]?, dataType: CoreDataType, into object: inout NSManagedObject) -> NSManagedObject? 
}

final class CoreDataAdapter: CoreDataAdapterProtocol {
	
	func translate(objects: [NSManagedObject]?, oneObject: NSManagedObject?,  dataType: CoreDataType) -> [Any]? {
		switch dataType {
			
		case .repository:
			guard let object = oneObject as? MORepository else { return nil}
			
			let dataForApp = Repository()
			dataForApp.branchesLink = object.branchesLink
			dataForApp.changes = object.changesLink
			dataForApp.collaboratorsLink = object.collaboratorsLink
			dataForApp.languageOfProject = object.languageOfRepository
			dataForApp.lastChange = object.lastChange
			dataForApp.name = object.name
			dataForApp.owner = User(login: object.owner ?? "")
			dataForApp.repoLink = object.repositoryLink
			
			return [dataForApp]
			
		case.project:
			guard let object = oneObject as? MOProject else { return nil }
			
			let dataForApp = Project(projectName: object.projectName, repoURL: object.repositoryURL, repositoryName: object.repositoryName, repo: nil)
			
			return [dataForApp]
			
		case .task:
			guard let object = oneObject as? MOTask else { return nil }
			
			let dataForApp = object.taskContent
			
			return [dataForApp]
			
			
			
		case .author:
			guard let objects = objects as? [MOAuthor] else { return nil }
			
			var datasForApp = [User]()
			
			for object in objects {
				let dataForApp = User(login: object.name)
				datasForApp.append(dataForApp)
			}
			
			return datasForApp
			
		case .branch:
			guard let objects = objects as? [MOBranch] else { return nil }
			
			var datasForApp = [Branch]()
			
			for object in objects {
				let dataForApp = Branch(name: object.name)
				datasForApp.append(dataForApp)
			}
			return datasForApp
			
		case .collaborator:
			guard let objects = objects as? [MOCollaborator] else { return nil }
			
			var datasForApp = [User]()
			
			for object in objects {
				let dataForApp = User(login: object.name)
				datasForApp.append(dataForApp)
			}
			
			return datasForApp
			
		case .commit:
			guard let objects = objects as? [MOCommit] else { return nil }
			
			var datasForApp = [Commit]()
			
			for object in objects {
				let dataForApp = Commit(sha: object.sha, message: object.message, author: Commit.Author(name: object.author ?? "", email: nil, date: nil), url: object.url, date: object.date)
				datasForApp.append(dataForApp)
			}
			
			return datasForApp
			
			
		}
	}
	
	func translateData(_ data: Any?, arrayOfData: [Any]?, dataType: CoreDataType, into object: inout NSManagedObject) -> NSManagedObject? {
		
		switch dataType {
		case .project:
			guard let data = data as? Project else { return nil }
			
			guard let object = object as? MOProject else { return nil }
//			let object = MOProject(context: context)
			object.projectName = data.projectName
			object.repositoryName = data.repositoryName
			object.repositoryURL = data.repoUrl
			
			return object
			
		case .repository:
			guard let data = data as? Repository else { return nil }
			
			guard let object = object as? MORepository else { return nil }
			
//			let object = MORepository(context: context)
			object.name = data.name
			
			object.branchesLink = data.branchesLink
			object.changesLink = data.changes
			object.collaboratorsLink = data.collaboratorsLink
			object.languageOfRepository = data.languageOfProject
			object.lastChange = data.lastChange
			object.owner = data.owner?.login
			object.repositoryLink = data.repoLink
			
			return object
			
		case .task:
			guard let data = data as? String else { return nil }
			
			guard let object = object as? MOTask else { return nil }
//			let object = MOTask(context: context)
			object.taskContent = data
			
			return object
			
			
		case .author:
			guard let data = data as? User else { return nil }
			
//			let object = MOAuthor(context: context)
			guard let object = object as? MOAuthor else { return nil }
			object.name = data.login
			
			return object
			
		case .branch:
			guard let data = data as? Branch else { return nil }
			
//			let object = MOBranch(context: context)
			guard let object = object as? MOBranch else { return nil }
			object.name = data.name
			
			return object
			
		case .collaborator:
			guard let data = data as? User else { return nil }
			
//			let object = MOCollaborator(context: context)
			guard let object = object as? MOCollaborator else { return nil }
			object.name = data.login
			
			return object
			
		case .commit:
			guard let data = data as? Commit else { return nil }
			
//			let object = MOCommit(context: context)
			guard let object = object as? MOCommit else { return nil }
			object.message = data.message
			object.author = data.author?.name
			object.sha = data.sha ?? ""
			object.url = data.url ?? ""
		
			return object
		}
		
	}
	
}
