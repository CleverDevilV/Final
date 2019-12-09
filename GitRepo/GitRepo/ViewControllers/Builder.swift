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
	static func createSomeWebView(with path: String) -> UIViewController?
	static func createProjectsTableView() -> UIViewController
	static func createProjectViewController(with project: Project?) -> UIViewController?
	static func createCollaboratorsTableView(with repository: Repository?) -> UIViewController?
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
	
	static func createSomeWebView(with path: String) -> UIViewController? {
		
		guard URL(string: path) != nil else { return nil }
		
		let view = SomeUrlWebViewController()
		let presenter = SomeWebPresenter(view: view, path: path)
		view.presenter = presenter
		
		return view
	}
	
	static func createProjectsTableView() -> UIViewController {
		var projectsBase: ProjectsBase
		if NSClassFromString("XCTestCase") != nil {
			projectsBase = ProjectsBase(with: [])
		} else {
			projectsBase = AppDelegate.shared.projectBase ?? ProjectsBase(with: [])
		}
		
		let view = ProjectsTableViewController()
		let presenter = ProjectsTablePresenter(view: view, projectsBase: projectsBase)
		view.presenter = presenter
		
		return view
	}
	
	static func createProjectViewController(with project: Project?) -> UIViewController? {
		
		guard let project = project else {
			print("project is nil")
			return nil }
		
		let view = ProjectViewController()
		let presenter = ProjectPresenter(view: view, project: project)
		view.presenter = presenter
		
		return view
	}
	
	static func createCollaboratorsTableView(with repository: Repository?) -> UIViewController? {
		
		if let repository = repository {
			let view = CollaboratorsTableViewController()
			let presenter = CollaboratorsTablePresenter(view: view, repository: repository)
			view.presenter = presenter
			
			return view
		} else {
			print("repositori is nil")
			return nil
		}
	}
	
}
