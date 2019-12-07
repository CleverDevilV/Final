//
//  RootVC.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit tests ???

class RootViewController: UIViewController {
	
	private var currentVC: UIViewController
	static let shared = RootViewController()
	var token: String = ""
	
	func copy(with zone: NSZone? = nil) -> Any {
		return self
	}
	
	init() {
		self.currentVC = StartAppViewControllerBuilder.createStartAppViewController() //StartAppViewController()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		addChild(currentVC)
		currentVC.view.frame = view.bounds
		view.addSubview(currentVC.view)
		currentVC.didMove(toParent: self) // завершает операцию добавления контроллера
	}
	
	func switchMainScreen() {
		let mainVC = BaseTabBarController()
		
		animateFadeTransition(to: mainVC)
	}
	
	private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
		currentVC.willMove(toParent: nil)
		addChild(new)
		
		transition(from: currentVC, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
		}) { completed in
			self.currentVC.removeFromParent()
			new.didMove(toParent: self)
			self.currentVC = new
			completion?()
		}
	}
	
	func switchToLogout() {
		let loginVC = StartAppViewControllerBuilder.createStartAppViewController() //StartAppViewController()
		let logouScreen = UINavigationController(rootViewController: loginVC)
		
		animateFadeTransition(to: logouScreen)
	}
}
