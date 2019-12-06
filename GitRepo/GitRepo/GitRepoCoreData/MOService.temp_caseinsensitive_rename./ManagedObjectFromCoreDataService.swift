//
//  ManagedObjectFromCoreDataService.swift
//  Old MORepositoryService.swift
//  GitRepo
//
//  Created by Дарья Витер on 05/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
import CoreData

enum BaseType {
	case projectBase
	case repositoryBase
}



protocol ManagedObjectServiceProtocol: class {
	func saveCoreDataObjectsFrom(base: Any?, baseType: BaseType)
	func getDataFromCoreData(to baseType: BaseType, completion: @escaping ([Any]?) ->())
}

final class ManagedObjectFromCoreDataService: CoreDataServiceProtocol {
	
	let writeContext = CoreDataStack.shared.writeContext
	let readContext = CoreDataStack.shared.readContext
	
	let repositoryEntityName = "Repository"
	let projectEntityName = "Project"
	
	private var adapter: CoreDataAdapterProtocol!
	
	private var repositoriesInCoreData: [MORepository]? {
		didSet {
			print("set repositoriesInCoreData")
		}
	}
	
	private var projectsInCoreData: [MOProject]? {
		didSet {
			print("set projectsInCoreData")
		}
	}
	
	init(withDeleting: Bool) {
//		self.readRepositoriesData()
		self.adapter = CoreDataAdapter()
		
		if withDeleting {
			self.deleteAllData()
		}
		
	}
	
	private func deleteAllData(){
		
		let arrayOfTypes = ["Project", "Repository","Author", "Branch", "Collaborator", "Commit", "Task"]
		
		readContext.perform {
			for type in arrayOfTypes {
				let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: type))
				do {
					try self.readContext.execute(DelAllReqVar)
					print("CoreData is empty, type: ", type)
				}
				catch {
					print("Type: ", type, ", error: ", error)
				}
			}
		}
		
		writeContext.perform {
			for type in arrayOfTypes {
				let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: type))
				do {
					try self.readContext.execute(DelAllReqVar)
					print("CoreData is empty, type: ", type)
				}
				catch {
					print("Type: ", type, ", error: ", error)
				}
			}
		}
	}
	
	/// Async function for save data from base into CoreData
	func saveCoreDataObjectsFrom(base: Any?, baseType: BaseType) {
		
		switch baseType {
		case .repositoryBase:
			
			guard let base = base as? RepositoriesBase else { return }
			
			for repository in base.repositories {
				
				writeContext.perform {
					
					var repositoryObjectStart: NSManagedObject = MORepository(context: self.writeContext)
					if let repositoryObject = self.adapter.translateData(repository, arrayOfData: nil, dataType: .repository, into: &repositoryObjectStart) as? MORepository {
						
						
						if let branches = repository.branches {
							for branch in branches {
								var branchObject: NSManagedObject = MOBranch(context: self.writeContext)
								if let branchObject = self.adapter.translateData(branch, arrayOfData: nil, dataType: .branch, into: &branchObject) as? MOBranch {
									branchObject.repository = repositoryObject
								}
							}
						}
						
						if let collaborators = repository.collaborators {
							for collaborator in collaborators {
								var collaboratorObject: NSManagedObject = MOCollaborator(context: self.writeContext)
								if let collaboratorObject = self.adapter.translateData(collaborator, arrayOfData: nil, dataType: .collaborator, into: &collaboratorObject) as? MOCollaborator {
									collaboratorObject.repository = repositoryObject
								}
							}
						}
						
						if let commits = repository.commits {
							for commit in commits {
								var commitObject: NSManagedObject = MOCommit(context: self.writeContext)
								if let commitObject = self.adapter.translateData(commit, arrayOfData: nil, dataType: .commit, into: &commitObject) as? MOCommit {
									commitObject.repository = repositoryObject
								}
							}
						}
						
						do {
							try self.writeContext.save()
							print("Success repository with name: ", repositoryObject.name)
//							print(repositoryObject)
						} catch {
							print(error)
						}
					}
				}
			}
			print("Repositories Saved into CoreData")
			
		case .projectBase :
			
			guard let base = base as? ProjectsBase else { return }
			
			for project in base.projects {
				
				writeContext.perform {
					
					var projectObject: NSManagedObject = MOProject(context: self.writeContext)
					if let projectObject = self.adapter.translateData(project, arrayOfData: nil, dataType: .project, into: &projectObject) as? MOProject {
						
						if let tasks = project.projectTasks {
							
							for task in tasks {
								var taskObject: NSManagedObject = MOTask(context: self.writeContext)
								if let taskObject = self.adapter.translateData(task, arrayOfData: nil, dataType: .task, into: &taskObject) as? MOTask {
									taskObject.project = projectObject
								}
							}
						}
						
						do {
							try self.writeContext.save()
							print("Success project with name: ", projectObject.projectName)
							//						print(projectObject)
						} catch {
							print(error)
						}
					}
				}
			}
			print("Project Saved into CoreData")
		default:
			break
		}
		
		
	}
	
//	public func getRepositoriesFromCoreData(completion: @escaping ([Repository]) ->()) {
//		
//		var repositories = [Repository]()
//		
////		guard let repositoriesInCoreData = repositoriesInCoreData else { return }
//		
//		getDataFromCoreData(to: .repositoryBase) {
//			repositoriesInCoreData in
//			
//			guard let repositoriesInCoreData = repositoriesInCoreData as? [MORepository] else { return }
//			
//			for repositoryObject in repositoriesInCoreData {
//				
//				if let repository = self.adapter.translate(objects: nil, oneObject: repositoryObject, dataType: .repository)?[0] as? Repository {
//					repository.branches = self.adapter.translate(objects: repositoryObject.branches?.allObjects as? [NSManagedObject], oneObject: nil, dataType: .branch) as? [Branch]
//					
//					
//					repository.collaborators = self.adapter.translate(objects: repositoryObject.collaborators?.allObjects as? [NSManagedObject], oneObject: nil, dataType: .collaborator) as? [User]
//					
//					repository.commits = self.adapter.translate(objects: repositoryObject.commits?.allObjects as? [NSManagedObject], oneObject: nil, dataType: .commit) as? [Commit]
//					
//					repositories.append(repository)
//					
////					return repositories
//				}
//			}
//			completion(repositories)
//		}
//	}
	
	/// Sync function for read data from CoreData
	public func getDataFromCoreData(to baseType: BaseType, completion: @escaping ([Any]?) ->()) {
		
		switch baseType {
		case .repositoryBase:
			
			readContext.performAndWait {
				let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: repositoryEntityName)
				
				var repositories = [Repository]()
				
				do {
					let results = try fetch.execute() as? [MORepository]
					if let results = results {
						print(results.count)
						repositoriesInCoreData = results
//						completion(results)
						//self.repositoriesInCoreData = results
					}
				} catch {
					print("Error reading data by FetchRequest, error: ", error)
				}
				
				guard let repositoriesInCoreData = repositoriesInCoreData as? [MORepository] else { return }
				
				for repositoryObject in repositoriesInCoreData {
					
					if let repository = self.adapter.translate(objects: nil, oneObject: repositoryObject, dataType: .repository)?[0] as? Repository {
						repository.branches = self.adapter.translate(objects: repositoryObject.branches?.allObjects as? [NSManagedObject], oneObject: nil, dataType: .branch) as? [Branch]
						
						
						repository.collaborators = self.adapter.translate(objects: repositoryObject.collaborators?.allObjects as? [NSManagedObject], oneObject: nil, dataType: .collaborator) as? [User]
						
						repository.commits = self.adapter.translate(objects: repositoryObject.commits?.allObjects as? [NSManagedObject], oneObject: nil, dataType: .commit) as? [Commit]
						
						repositories.append(repository)
						
						//					return repositories
					}
				}
				
				completion(repositories)
			}
			
		case .projectBase:
			
			readContext.performAndWait {
				let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: projectEntityName)
				
				var projects = [Project]()
				
				do {
					let results = try fetch.execute() as? [MOProject]
					if let results = results {
						print(results.count)
						projectsInCoreData = results
						//						completion(results)
						//self.repositoriesInCoreData = results
					}
				} catch {
					print("Error reading data by FetchRequest, error: ", error)
				}
				
				guard let projectsInCoreData = projectsInCoreData as? [MOProject] else { return }
				
				for projectObject in projectsInCoreData {
					
					if let project = self.adapter.translate(objects: nil, oneObject: projectObject, dataType: .project)?[0] as? Project {
						project.projectTasks = self.adapter.translate(objects: projectObject.tasks?.allObjects as? [NSManagedObject], oneObject: nil, dataType: .task) as? [String]
						
						projects.append(project)
					}
				}
				
				completion(projects)
			}
		}
	}
	
	
	
//	private func readRepositoriesData(completion: @escaping ([MORepository]) ->()) {
//
//		readContext.performAndWait {
//			let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: repositoryEntityName)
//
//			do {
//				let results = try fetch.execute() as? [MORepository]
//				//				print(results?.count)
//				if let results = results {
//					self.repositoriesInCoreData = results
//					//					complition(results)
//					//					for result in results {
//					//						print(result.name)
//					//					}
//				}
//			} catch {
//				print("Error reading data by FetchRequest, error: ", error)
//			}
//
//		}
//
//
//			let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: repositoryEntityName)
//
//			do {
//				let results = try fetch.execute() as? [MORepository]
////				print(results?.count)
//				if let results = results {
//					self.repositoriesInCoreData = results
////					complition(results)
////					for result in results {
////						print(result.name)
////					}
//				}
//			} catch {
//				print("Error reading data by FetchRequest, error: ", error)
//			}
//
//	}
	
	
}
