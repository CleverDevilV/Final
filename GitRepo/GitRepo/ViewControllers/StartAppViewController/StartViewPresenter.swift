//
//  StartViewPresenter.swift
//  GitRepo
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
// Unit tests

protocol StartViewProtocol: class {
	func setLoader(loader: LoaderProtocol?)
}

protocol StartViewPresenterProtocol: class {
	init(view: StartViewProtocol, loader: LoaderProtocol?)
	
	func setupLoader()
}

class StartViewPresenter: StartViewPresenterProtocol {
	
	let view: StartViewProtocol?
	let loader: LoaderProtocol?
	
	required init(view: StartViewProtocol, loader: LoaderProtocol?) {
		self.view = view
		self.loader = loader
	}
	
	func setupLoader() {
		self.view?.setLoader(loader: loader)
	}
}


