//
//  Builder.swift
//  GitRepo
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

protocol BuilderProtocol: class {
	static func createStartAppViewController() -> UIViewController
	static func createSettingsViewController() -> UIViewController
	static func createSomeWebView(with path: String) -> UIViewController
}

class Builder: BuilderProtocol {
	
	static func createStartAppViewController() -> UIViewController {
		
		let logoutCommand = LogOutCommand()
		var session: URLSession
		var loader: Loader
		
	// Loader
		if NSClassFromString("XCTestCase") != nil {
			session = URLSession(configuration: .default)
			loader = Loader(githubNetworkManager: nil, firebaseNetworkManager: nil, coreDataService: nil)
		} else {
			session = AppDelegate.shared.session
			let githubNetworkManager = GitHubNetworkManager(with: session)
			let firebaseNetworkManager = FirebaseNetworkManager(with: session)
			let coreDataManagerService = ManagedObjectFromCoreDataService(withDeleting: false, writeContext: CoreDataStack.shared.writeContext, readContext: CoreDataStack.shared.readContext)
			
			loader = Loader(githubNetworkManager: githubNetworkManager, firebaseNetworkManager: firebaseNetworkManager, coreDataService: coreDataManagerService)
		}
		
	// View
		let view = StartAppViewController()
		let presenter = StartViewPresenter(view: view, loader: loader, command: logoutCommand)
		view.presenter = presenter
		
		return view
	}
	
	static func createSettingsViewController() -> UIViewController {
		
		let logoutCommand = LogOutCommand()
		let view = SettingsViewController()
		let presenter = SettingsPresenter(view: view, command: logoutCommand)
		view.presenter = presenter
		
		return view
	}
	
	static func createSomeWebView(with path: String) -> UIViewController {
		let view = SomeUrlWebViewController()
		let presenter = SomeWebPresenter(view: view, path: path)
		view.presenter = presenter
		
		return view
	}
	
}
