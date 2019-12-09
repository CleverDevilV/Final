//
//  Builder.swift
//  GitRepo
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

protocol BuilderProtocol: class {
	static func createStartAppViewController() -> UIViewController
}

class Builder: BuilderProtocol {
	
	static func createStartAppViewController() -> UIViewController {
		
		let loader = LoaderBuilder.createLoader()
		let view = StartAppViewController()
		let presenter = StartViewPresenter(view: view, loader: loader)
		view.presenter = presenter
		
		return view
	}
	
}
