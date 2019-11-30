//
//  SettingsViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
	
	var switcher = UISwitch()
	var loginLabel = UILabel()
	private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .white
		
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		
		loginLabel.text = UserDefaults.standard.get(with: .oauth_user_login)
		
		view.addSubview(tableView)
		tableView.addSubview(switcher)
		tableView.addSubview(loginLabel)
		
		setupViews()
    }
	
	func setupViews() {
		
//		view.addSubview(switcher)
		
		switcher.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			switcher.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
			switcher.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)//,
//			switcher.heightAnchor.constraint(equalToConstant: 50),
//			switcher.widthAnchor.constraint(equalToConstant: 100)
			])
		switcher.addTarget(self, action: #selector(switcherChangePosition), for: .valueChanged)
		
		loginLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
			loginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
			loginLabel.heightAnchor.constraint(equalToConstant: 44),
			loginLabel.widthAnchor.constraint(equalToConstant: 50)
			])
		
	}
	@objc
	func switcherChangePosition() {
		UserDefaults.standard.remove(with: .oauth_access_token)
		
		print("userdef token: ", UserDefaults.standard.get(with: .oauth_access_token))
	}

}
