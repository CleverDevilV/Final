//
//  BaseTabBarController.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let projectsVC = UINavigationController(rootViewController: ProjectsTableVC() )
		projectsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
		
		let repoVC = UINavigationController(rootViewController: ReposTableViewController())
		repoVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
		
		let settingsVC = SettingsViewController()
		settingsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
		
		viewControllers = [projectsVC, repoVC, settingsVC]
		tabBar.unselectedItemTintColor = UIColor(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1) //#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
		tabBar.backgroundColor = UIColor(red: 0.2164473236, green: 0.1480196118, blue: 0.05771636218, alpha: 0.5) //#colorLiteral(red: 0.2164473236, green: 0.1480196118, blue: 0.05771636218, alpha: 0.5)
		
		
//		updateData()
	}
	
	func updateData() {
		
		if !UserDefaults.standard.isExist(with: .oauth_access_token) {
			present(RequestViewController(), animated: false, completion: nil)
		}
	}
}
