//
//  StartAppViewControllerBuilder.swift
//  GitRepo
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// No Unit Tests

protocol StartAppViewControllerBuilderProtocol: class {
	static func createStartAppViewController() -> UIViewController
}

class StartAppViewControllerBuilder: StartAppViewControllerBuilderProtocol {
	
	static func createStartAppViewController() -> UIViewController {
		
		let loader = LoaderBuilder.createLoader()
		let view = StartAppViewController()
		let presenter = StartViewPresenter(view: view, loader: loader)
		view.presenter = presenter
		
		return view
	}
}
