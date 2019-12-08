//
//  LoaderBuilder.swift
//  GitRepo
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// No Unit Tests

protocol LoaderBuilderProtocol: class {
	static func createLoader() -> LoaderProtocol
}

/// Tests - [LoaderBuilderTests](x-source-tag://LoaderBuilderTests)
class LoaderBuilder: LoaderBuilderProtocol {
	static func createLoader() -> LoaderProtocol {
		
		var session: URLSession!
		var loader: LoaderProtocol!
		
		
		let isRunningTests = NSClassFromString("RootViewControllerTests") != nil
		
		if !isRunningTests {
			session = AppDelegate.shared.session
			let githubNetworkManager = GitHubNetworkManager(with: session)
			let firebaseNetworkManager = FirebaseNetworkManager(with: session)
			
			let coreDataManagerService = ManagedObjectFromCoreDataService(withDeleting: false, writeContext: CoreDataStack.shared.writeContext, readContext: CoreDataStack.shared.readContext)
			loader = Loader(githubNetworkManager: githubNetworkManager, firebaseNetworkManager: firebaseNetworkManager, coreDataService: coreDataManagerService)
		} else {
			session = URLSession(configuration: .default)
			loader = Loader(githubNetworkManager: nil, firebaseNetworkManager: nil, coreDataService: nil)
		}
		
		return loader
	}
}
