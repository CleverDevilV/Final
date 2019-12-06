//
//  CoreDataService.swift
//  GitRepo
//
//  Created by Дарья Витер on 05/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit
import CoreData

final class CoreDataService {
	
	private var delegate: NSFetchedResultsControllerDelegate!
	private var stack = CoreDataStack.shared
	private var readContext = CoreDataStack.shared.readContext
	private var writeContext = CoreDataStack.shared.writeContext
	
	var fetchResultControllerForProject: NSFetchedResultsController<MOProject>?
	
	/// Async function
	public func writeData(_ data: Data?) {
		
		
		let context = stack.writeContext

		context.performAndWait {
			let project = MORepository(context: context)

			project.name = "My project"

			do {
				try context.save()
				print("Success project")
			} catch {
				print(error.localizedDescription)
			}
		}
	}
	
	private func traslateRepositoryData(_ repositories: [Repository]) {
		writeContext.perform {
			for repository in repositories {
				let repositoryObject = MORepository(context: self.writeContext)
				repositoryObject.name = repository.name
				repositoryObject.branchesLink = repository.branchesLink
				repositoryObject.changesLink = repository.changes
				repositoryObject.collaboratorsLink = repository.collaboratorsLink
				repositoryObject.languageOfRepository = repository.languageOfProject
				repositoryObject.lastChange = repository.lastChange
				repositoryObject.owner = repository.owner?.login
				repositoryObject.repositoryLink = repository.repoLink
				
			}
		}
	}
	
	
	public func writeTask(_ completion: @escaping (MOTask) ->()) {
		
		let context = stack.readContext
		
		context.performAndWait {
			let project = MOTask(context: context)
			
			project.taskContent = "My project task"
			
			do {
				try context.save()
				print("Success task")
				completion(project)
			} catch {
				print(error.localizedDescription)
			}
		}
	}
	
	/// Sync func
	public func readData(_ entityName: String, completion: @escaping ([MOProject]) ->()) {
		
		let context = stack.readContext
		
		context.perform {
			
			let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
			
			do {
				let results = try fetch.execute() as? [MOProject]
//				print(results)
				if let results = results {
					for result in results {
						print(result.projectName)
					}
					completion(results)
				}
			} catch {
				print("Error reading data by FetchRequest, error: ", error)
			}
		}
	}
	
	public func readDataTasks(_ entityName: String, completion: @escaping ([MOTask]) ->()) {
		
		let context = stack.readContext
		
		context.perform {
			
			let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
			
			do {
				let results = try fetch.execute() as? [MOTask]
//				print(results)
				if let results = results {
//					for result in results {
//						print(result.projectName)
//					}
					completion(results)
				}
			} catch {
				print("Error reading data by FetchRequest, error: ", error)
			}
		}
	}
	
	
	func deleteAllData(){
		
		let managedContext = stack.readContext
		
		let arrayOfTypes = ["Project", "Repository","Author", "Branch", "Collaborator", "Commit", "Task"]
		
		for type in arrayOfTypes {
			let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: type))
			do {
				try managedContext.execute(DelAllReqVar)
				print("CoreData is empty, type: ", type)
			}
			catch {
				print("Type: ", type, ", error: ", error)
			}
		}
	}
	
}
