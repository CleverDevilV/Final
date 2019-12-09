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
}

class Builder: BuilderProtocol {
	
	static func createStartAppViewController() -> UIViewController {
		
		let logoutCommand = LogOutCommand()
		let loader = LoaderBuilder.createLoader()
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
	
}
