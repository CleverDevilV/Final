//
//  CoreDataStack.swift
//  GitRepo
//
//  Created by Дарья Витер on 05/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
import CoreData

internal final class CoreDataStack {
	static let shared: CoreDataStack = {
		let coreDataStack = CoreDataStack()
		return coreDataStack
	}()
	
	init() {
		createCoordinator()
	}
	
	/// Sync Context
	lazy var readContext: NSManagedObjectContext = {
		let readContext  = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
		readContext.persistentStoreCoordinator = coordinator
		return readContext
	}()
	
	/// Async Context
	lazy var writeContext: NSManagedObjectContext = {
		let writeContext  = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
		writeContext.persistentStoreCoordinator = coordinator
		return writeContext
	}()
	
	private var managedObjectModel: NSManagedObjectModel = {
		let url = Bundle.main.url(forResource: "GitRepoCoreData", withExtension: "momd")!
		let managedObjectModel = NSManagedObjectModel(contentsOf: url)
		return managedObjectModel!
	}()
	
	private var coordinator: NSPersistentStoreCoordinator!
	
	func createCoordinator() {
		coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
		
		let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
		let path = paths.first!
		let modelPath = URL(fileURLWithPath: path).appendingPathComponent("GitRepoCoreData").relativePath
		let url = URL(fileURLWithPath: modelPath, isDirectory: true)
		do {
			try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true])
		} catch {
			print(error)
		}
		
	}
}

//extension CoreDataStack {
//
//	public func writeOwner() -> MOOwner? {
//
//		self.deleteAllData()
//
//		let stack = CoreDataStack.shared
//		let context = stack.writeContext
//
//		context.performAndWait {
//
//			let owner = MOOwner(context: context)
//			owner.name = "Me"
//
//			do {
//				try context.save()
//				print("Success")
//			} catch {
//				print(error.localizedDescription)
//			}
//		}
//
//		//		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Owner")
//
//		let fetch2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Owner")
//		let result2 = try! fetch2.execute() as? [MOOwner]
//		print(result2)
//
//		//		do {
//		//			if let results = try readContext.execute(fetchRequest) as? [moo] {
//		//				for result in results {
//		//					if let deviceType = result.value(forKey: "deviceType"), let name = result.value(forKey: "name") {
//		//						print("Device \(deviceType) named \(name)")
//		//					}
//		//				}
//		//				print(results)
//		//			}
//		//		} catch {
//		//			print(error)
//		//			print("Error with fetch")
//		//		}
//
//		return nil
//	}
//
//	/// Sync function
//	public func write() {
//
//		let stack = CoreDataStack.shared
//		let context = stack.writeContext
//
//		context.performAndWait {
//			let animal1 = MOAnimal(context: context)
//
//			animal1.name = "cat 1"
//			animal1.legsCount = 4
//			//			animal1.owner = owner
//
//			let animal2 = MOAnimal(context: context)
//
//			animal2.name = "cat 2"
//			animal2.legsCount = 4
//			//			animal2.owner = owner
//
//			do {
//				try context.save()
//				print("Success")
//			} catch {
//				print(error.localizedDescription)
//			}
//		}
//	}
//
//	/// Asinc function
//	public func read() {
//		let stack = CoreDataStack.shared
//		let context = stack.readContext
//
//		context.perform {
//
//			let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Animal")
//			let result = try! fetch.execute() as? [MOAnimal]
//			//			print(result?.first!)
//			print(result?.last!.name)
//			print(result?.last!)
//
//
//			let fetch2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Owner")
//			let result2 = try! fetch2.execute() as? [MOOwner]
//			//			print(result?.first!)
//			print(result2?.last!.name)
//			print(result?.last!)
//
//			self.deleteAllData()
//		}
//	}
//
//	private func deleteAllData(){
//
//		let managedContext = self.readContext
//		let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Owner"))
//		do {
//			try managedContext.execute(DelAllReqVar)
//			print("CoreData is empty")
//		}
//		catch {
//			print(error)
//		}
//
//		let DelAllReqVarTwo = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Animal"))
//		do {
//			try managedContext.execute(DelAllReqVarTwo)
//			print("CoreData is empty")
//		}
//		catch {
//			print(error)
//		}
//	}
//}
