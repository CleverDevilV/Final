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

final class ManagedObjectFromCoreDataService {
	
	let writeContext = CoreDataStack.shared.writeContext
	let readContext = CoreDataStack.shared.readContext
	
	var repositoryEntytiName = "Repository"
	private var adapter: CoreDataAdapterProtocol!
	
	private var repositoriesInCoreData: [MORepository]? {
		didSet {
			print("set repositoriesInCoreData")
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
		
		readContext.performAndWait {
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
	
	
	
	enum BaseType {
		case projectBase
		case repositoryBase
	}
	
	/// Aync function
	func addObjectsTo(base: Any?, baseType: BaseType) {
		
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
	
	public func getRepositoriesFromCoreData() -> [Repository]? {
		
		var repositories = [Repository]()
		
		guard let repositoriesInCoreData = repositoriesInCoreData else { return nil }
		
		for repositoryObject in repositoriesInCoreData {
			
			if let repository = adapter.translate(objects: nil, oneObject: repositoryObject, dataType: .repository)?[0] as? Repository {
				repository.branches = adapter.translate(objects: repositoryObject.branches?.allObjects as? [NSManagedObject], oneObject: nil, dataType: .branch) as? [Branch]
				
				
				repository.collaborators = adapter.translate(objects: repositoryObject.collaborators?.allObjects as? [NSManagedObject], oneObject: nil, dataType: .collaborator) as? [User]
				
				repository.commits = adapter.translate(objects: repositoryObject.commits?.allObjects as? [NSManagedObject], oneObject: nil, dataType: .commit) as? [Commit]
				
				repositories.append(repository)
			}
		}
		
		return repositories
	}
	
	private func readRepositoriesData() {
		writeContext.performAndWait {
			
			let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: repositoryEntytiName)
			
			do {
				let results = try fetch.execute() as? [MORepository]
//				print(results?.count)
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
