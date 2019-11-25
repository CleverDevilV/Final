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
		
		let repoVC = UINavigationController(rootViewController: ReposTableVC())
		repoVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
		
		viewControllers = [projectsVC, repoVC]
		
	}
}
