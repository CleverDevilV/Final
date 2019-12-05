//
//  MORepositoryService.swift
//  GitRepo
//
//  Created by Дарья Витер on 05/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
import CoreData

final class MORepositoryService {
	
	let context = CoreDataStack.shared.readContext
	var repositoryEntytiName = "Repository"
	private var adapter = CoreDataAdapter()
	
	private var repositoriesInCoreData: [MORepository]? {
		didSet {
			print("set repositoriesInCoreData")
		}
	}
	
	init() {
		self.readRepositoriesData()
	}
	
	func addObjectsTo(repository: Repository) {
		
		context.performAndWait {
			
			let repositoryObject = MORepository(context: context)
			repositoryObject.name = repository.name
			repositoryObject.branchesLink = repository.branchesLink
			repositoryObject.changesLink = repository.changes
			repositoryObject.collaboratorsLink = repository.collaboratorsLink
			repositoryObject.languageOfRepository = repository.languageOfProject
			repositoryObject.lastChange = repository.lastChange
			repositoryObject.owner = repository.owner?.login
			repositoryObject.repositoryLink = repository.repoLink
			
			if let branches = repository.branches {
				for branch in branches {
					
					let branchObject = MOBranch(context: context)
					branchObject.name = branch.name
					
					branchObject.repository = repositoryObject
				}
			}
			
			if let collaborators = repository.collaborators {
				for collaborator in collaborators {
					let collaboratorObject = MOCollaborator(context: context)
					collaboratorObject.name = collaborator.login
					
					collaboratorObject.repository = repositoryObject
				}
			}
			
			if let commits = repository.commits {
				for commit in commits {
					let commitObject = MOCommit(context: context)
					commitObject.author = commit.author?.name
					commitObject.date = commit.date
					commitObject.message = commit.message
					commitObject.sha = commit.sha ?? ""
					commitObject.url = commit.url ?? ""
					
					commitObject.repository = repositoryObject
				}
			}
			
			
			do {
				try context.save()
				print("Success project")
				print(repositoryObject)
			} catch {
				print(error)
			}
		}
	}
	
	public func getRepositoriesFromCoreData() -> [Repository]? {
		
		var repositories = [Repository]()
		
		guard let repositoriesInCoreData = repositoriesInCoreData else { return nil }
		
		for repositoryObject in repositoriesInCoreData {
			
			if let repository = adapter.translate(objects: nil, oneObject: repositoryObject, dataType: .repository)?[0] as? Repository {
				repository.branches = adapter.translate(objects: repositoryObject.branches?.allObjects as? [NSManagedObject], dataType: .branch) as? [Branch]
				
				
				repository.collaborators = adapter.translate(objects: repositoryObject.collaborators?.allObjects as? [NSManagedObject], dataType: .collaborator) as? [User]
				
				repository.commits = adapter.translate(objects: repositoryObject.commits?.allObjects as? [NSManagedObject], dataType: .commit) as? [Commit]
				
				repositories.append(repository)
			}
		}
		
		return repositories
	}
	
	private func readRepositoriesData() {
		context.performAndWait {
			
			let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: repositoryEntytiName)
			
			do {
				let results = try fetch.execute() as? [MORepository]
				print(results?.count)
				if let results = results {
					self.repositoriesInCoreData = results
//					complition(results)
//					for result in results {
//						print(result.name)
//					}
				}
			} catch {
				print("Error reading data by FetchRequest, error: ", error)
			}
		}
	}
	
	
}
