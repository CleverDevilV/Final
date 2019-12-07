//
//  CoreDataStack.swift
//  GitRepo
//
//  Created by Дарья Витер on 05/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
import CoreData

// Unit tests???

/**
Core Data Stack Class. [CoreDataStack](x-source-tag://CoreDataStack).
Tests - [CoreDataStackTests](x-source-tag://CoreDataStackTests)
 ```
 Singleton shared: CoreDataStack()
 [CoreDataStack](x-source-tag://CoreDataStack)
```
*/
///- Tag: CoreDataStack
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
	
	private func createCoordinator() {
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
