//
//  ModuleBuilder.swift
//  GitRepo
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

protocol BuilderProtocol: class {
	static func createStart() -> UIViewController
}

class StartAppViewControllerBuilder: BuilderProtocol {
	static func createStart() -> UIViewController {
//		let model = Person
		
		let view = StartAppViewController()
		let presenter = StartViewPresenter(view: view)
		view.presenter = presenter
		
		return view
	}
	
	
}
