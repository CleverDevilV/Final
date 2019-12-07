//
//  RootViewControllerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class MockManagedViewControllerByRootViewController: ManagedViewControllerByRootViewControllerProtocol {
	
	var nameOfFunctionInView: String?
	
	var rootViewController: RootViewControllerProtocol!
	
	func setupRootViewController(_ rootView: RootViewControllerProtocol) {
		self.rootViewController = rootView
	}
	func switchRootViewControllerToMainScreen() {
		rootViewController.switchMainScreen()
	}
	
	func switchRootViewControllerToLogoutScreen() {
		rootViewController.switchToLogout()
	}
	
}

//class MockRootViewController: RootViewControllerProtocol {
//	
//	var nameOfFunctionInRoot: String?
//	
//	func switchMainScreen() {
//		nameOfFunctionInRoot = "switchMainScreen"
//	}
//	
//	func switchToLogout() {
//		nameOfFunctionInRoot = "switchToLogout"
//	}
//	
//	
//}

class RootViewControllerTests: XCTestCase {
	
	var rootViewController: RootViewControllerProtocol!
	var mockManagedViewController = MockManagedViewControllerByRootViewController()

    override func setUp() {
		rootViewController = RootViewController()
		mockManagedViewController = MockManagedViewControllerByRootViewController()
		mockManagedViewController.setupRootViewController(rootViewController)
    }

    override func tearDown() {
		rootViewController = nil
//		mockManagedViewController = nil
    }
	
//	func testCallFunction() {
//		// arrange
//		// act
//		rootViewController = MockRootViewController()
//		mockManagedViewController.setupRootViewController(rootViewController)
//		mockManagedViewController.switchRootViewControllerToMainScreen()
		// assert
//	}

}
