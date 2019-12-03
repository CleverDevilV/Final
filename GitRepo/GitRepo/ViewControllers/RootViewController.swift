//
//  RootVC.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
	
	private var currentVC: UIViewController
	static let shared = RootViewController()
	var token: String = ""
	
	func copy(with zone: NSZone? = nil) -> Any {
		return self
	}
	
	init() {
		self.currentVC = StartAppViewController()
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
	
	
	
	/*
	//MARK: - Navigation
	
	func showLoginScreen() {
		let newNC = UINavigationController(rootViewController: LoginViewController())
		addChild(newNC)
		newNC.view.frame = view.bounds
		view.addSubview(newNC.view)
		newNC.didMove(toParent: self)
		
		// подготавливаем currentVC к удалению
		currentVC.willMove(toParent: nil)
		// удаляем currentVC
		currentVC.view.removeFromSuperview()
		currentVC.removeFromParent()
		currentVC = newNC
	}
	
	func switchMainScreen() {
		let mainVC = MainViewController()
		let mainScreen = UINavigationController(rootViewController: mainVC)
	
		animateFadeTransition(to: mainScreen)
	}
	
	func switchToLogout() {
		let loginVC = LoginViewController()
		let logouScreen = UINavigationController(rootViewController: loginVC)
		
		animatedDismissTransition(to: logouScreen)
	}
	
	//MARK: - Animation for transition
	
	private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
		
		currentVC.willMove(toParent: nil)
		addChild(new)
		
		transition(from: currentVC, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {}) { completed in
			self.currentVC.removeFromParent()
			new.didMove(toParent: self)
			self.currentVC = new
			completion?() // чтобы уведомить вызывающий метод
		}
	}
	
	// слайд-анимация
	private func animatedDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
		
		new.view.frame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
		currentVC.willMove(toParent: nil)
		addChild(new)
		transition(from: currentVC, to: new, duration: 0.3, options: [], animations: {new.view.frame = self.view.bounds}) { completed in
			self.currentVC.removeFromParent()
			new.didMove(toParent: self)
			self.currentVC = new
			completion?()
		}
	}
	*/
	
}

//extension RootVC: AuthViewControllerDelegateMy {
//	func handleTokenChanged(token: String) {
//		self.token = token
//		print("New token \(token)")
//		updateData()
//	}
//}
