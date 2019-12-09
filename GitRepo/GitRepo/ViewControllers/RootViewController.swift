//
//  RootVC.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit tests ???

protocol ManagedViewControllerByRootViewControllerProtocol {
	func setupRootViewController(_ rootView: RootViewControllerProtocol)
	
	func switchRootViewControllerToMainScreen()
	func switchRootViewControllerToLogoutScreen()
}

/// Root class for presents View Controllers
class RootViewController: UIViewController, RootViewControllerProtocol {
	
	private var currentVC: UIViewController!
//	static let shared = RootViewController()
	var token: String = ""
	
	
	init() {
		self.currentVC = Builder.createStartAppViewController() //StartAppViewController()
		
		super.init(nibName: nil, bundle: nil)
		
		if let currentVC: ManagedViewControllerByRootViewControllerProtocol = self.currentVC as? ManagedViewControllerByRootViewControllerProtocol {
			currentVC.setupRootViewController(self)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		addChild(currentVC)
		currentVC.view.frame = view.bounds
		view.addSubview(currentVC.view)
		currentVC.didMove(toParent: self)
	}
	
	/// Switch View to Main view with TabBar
	func switchMainScreen() {
		let mainVC = BaseTabBarController()
		
		animateFadeTransition(to: mainVC)
	}
	
	/// Switch View to Start View Controller after Logout User
	func switchToLogout() {
		let loginVC = Builder.createStartAppViewController() //StartAppViewController()
		let logouScreen = UINavigationController(rootViewController: loginVC)
		
		animateFadeTransition(to: logouScreen)
	}
	
	/// Animation
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
}
