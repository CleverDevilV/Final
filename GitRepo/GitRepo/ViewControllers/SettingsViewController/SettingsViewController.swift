//
//  SettingsViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
	
	private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .white
		title = "Профиль"
		
		setupViews()
    }
	
	func setupViews() {
		
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		tableView.tableFooterView = UIView()
		
		tableView.dataSource = self
		
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
		
		return cell
	}
}

extension SettingsViewController: LogoutSettingsTableViewCellDelegate {
	func logoutButtonTapped() {
		let logOtcommand = LogOutCommand()
		logOtcommand.logOut()
		
		AppDelegate.shared.rootViewController.switchToLogout()
	}
}

extension SettingsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.cellForRow(at: indexPath)?.isSelected = false
	}
}
