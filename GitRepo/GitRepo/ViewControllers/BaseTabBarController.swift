//
//  BaseTabBarController.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// No Unit Tests

class BaseTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let projectsVC = UINavigationController(rootViewController: ProjectsTableVC() )
		projectsVC.tabBarItem = UITabBarItem(title: "Проекты", image: UIImage(named: "project"), tag: 0)
		
		let repoVC = UINavigationController(rootViewController: RepositoriesTableViewController())
		repoVC.tabBarItem = UITabBarItem(title: "Репозитории", image: UIImage(named: "github"), tag: 1)
		
		let settingsVC = UINavigationController(rootViewController: SettingsViewController())
		settingsVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "settings"), tag: 2)
		
		viewControllers = [projectsVC, repoVC, settingsVC]
		tabBar.unselectedItemTintColor = UIColor(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
		
		tabBar.backgroundColor = UIColor(red: 0.2164473236, green: 0.1480196118, blue: 0.05771636218, alpha: 0.5) //#colorLiteral(red: 0.2164473236, green: 0.1480196118, blue: 0.05771636218, alpha: 0.5)
		
	}
}
