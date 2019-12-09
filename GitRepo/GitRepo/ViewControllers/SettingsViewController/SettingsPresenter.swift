//
//  SettingsPresenter.swift
//  GitRepo
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

protocol SettingsViewProtocol: class {
	func setupLogoutCommang(_ command: LogOutCommand)
}

protocol SettingsPresenterProtocol: class {
	init (view: SettingsViewProtocol, command: LogOutCommand)
	func setCommand()
}

class SettingsPresenter: SettingsPresenterProtocol {
	
	weak var settingsView: SettingsViewProtocol?
	let logoutCommand: LogOutCommand?
	required init(view: SettingsViewProtocol, command: LogOutCommand) {
		self.settingsView = view
		self.logoutCommand = command
	}
	
	func setCommand() {
		guard let logoutCommand = logoutCommand else {
			print("Can't create logoutCommand")
			return
		}
		settingsView?.setupLogoutCommang(logoutCommand)
	}
}
