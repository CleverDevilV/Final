//
//  SettingsViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit Tests

/// [Tests](x-source-tag://SettingsViewControllerTests).
class SettingsViewController: UIViewController {
	
	public var presenter: SettingsPresenter!
	
	private var tableView: UITableView!
	private var logoutCommand: LogOutCommand!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .white
		title = "Профиль"
		
		presenter.setCommand()
		
		setupViews()
    }
	
	func setupViews() {
		
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		tableView.tableFooterView = UIView()
		
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.register(LoginSettingsTableViewCell.self, forCellReuseIdentifier: LoginSettingsTableViewCell.reusedId)
		tableView.register(LogoutSettingsTableViewCell.self, forCellReuseIdentifier: LogoutSettingsTableViewCell.reusedId)
		
		view.addSubview(tableView)
	}
}

extension SettingsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
		
		switch indexPath.row {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: LoginSettingsTableViewCell.reusedId, for: indexPath) as! LoginSettingsTableViewCell
			return cell
		case 1:
			let cell = tableView.dequeueReusableCell(withIdentifier: LogoutSettingsTableViewCell.reusedId, for: indexPath) as! LogoutSettingsTableViewCell
			cell.delegate = self
			return cell
		default:
			return cell
		}
	}
}

extension SettingsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.cellForRow(at: indexPath)?.isSelected = false
		
		if indexPath.row == 1 {
			logoutButtonTapped()
		}
	}
}

extension SettingsViewController: LogoutSettingsTableViewCellDelegate {
	
	/// Logout User
	func logoutButtonTapped() {
		
		logoutCommand.logOut()
		
		guard NSClassFromString("XCTestCase") == nil else { return }
//		guard AppDelegate.shared != nil else { return }
		AppDelegate.shared.rootViewController.switchToLogout()
	}
}

extension SettingsViewController: SettingsViewProtocol {
	func setupLogoutCommang(_ command: LogOutCommand) {
		self.logoutCommand = command
	}
}
