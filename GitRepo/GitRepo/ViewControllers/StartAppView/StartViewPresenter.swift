//
//  StartViewPresenter.swift
//  GitRepo
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
// Unit tests

protocol StartViewProtocol: class {
	func setLoader(loader: LoaderProtocol?)
	func setLogoutCommand(command: LogOutCommand?)
}

protocol StartViewPresenterProtocol: class {
	init(view: StartViewProtocol, loader: LoaderProtocol?, command: LogOutCommand)
	
	func setupLoader()
	func setupLogCoutCommand()
}

/// Presenter
class StartViewPresenter: StartViewPresenterProtocol {
	
	let view: StartViewProtocol?
	let loader: LoaderProtocol?
	let logoutCommand: LogOutCommand?
	
	required init(view: StartViewProtocol, loader: LoaderProtocol?, command: LogOutCommand) {
		self.view = view
		self.loader = loader
		self.logoutCommand = command
	}
	
	func setupLoader() {
		self.view?.setLoader(loader: loader)
	}
	
	func setupLogCoutCommand() {
		view?.setLogoutCommand(command: logoutCommand)
	}
}


