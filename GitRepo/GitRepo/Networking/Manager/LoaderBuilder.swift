//
//  LoaderBuilder.swift
//  GitRepo
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit Tests


protocol LoaderBuilderProtocol: class {
	static func createLoader() -> LoaderProtocol
}

/// Tests - [LoaderBuilderTests](x-source-tag://LoaderBuilderTests)
class LoaderBuilder: LoaderBuilderProtocol {
	static func createLoader() -> LoaderProtocol {
		
		let session = AppDelegate.shared.session
		
		let githubNetworkManager = GitHubNetworkManager(with: session)
		let firebaseNetworkManager = FirebaseNetworkManager(with: session)
		
		let coreDataManagerService = ManagedObjectFromCoreDataService(withDeleting: false, writeContext: CoreDataStack.shared.writeContext, readContext: CoreDataStack.shared.readContext)
		let loader = Loader(githubNetworkManager: githubNetworkManager, firebaseNetworkManager: firebaseNetworkManager, coreDataService: coreDataManagerService)
		
		return loader
	}
}
