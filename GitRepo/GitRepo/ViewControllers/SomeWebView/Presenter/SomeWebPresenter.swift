//
//  SomeWebPresenter.swift
//  GitRepo
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit Tests

protocol SomeWebViewProtocol: class {
	func setURL(_ url: URL)
}

protocol SomeWebPresenterProtocol: class {
	init(view: SomeWebViewProtocol?, path url: String?)
	
	func setURL()
}

 /// Unit Tests - [SomeWebPresenterTests](x-source-tag://SomeWebPresenterTests)
class SomeWebPresenter: SomeWebPresenterProtocol {
	
	weak var view: SomeWebViewProtocol?
	let strURL: String?
	
	required init(view: SomeWebViewProtocol?, path url: String?) {
		self.view = view
		self.strURL = url
	}
	
	func setURL() {
		guard strURL != nil else {
			print("strURL is nil!")
			return
		}
		guard let url = URL(string: strURL!) else {
			print("can't create url")
		return
		}
		
		view?.setURL(url)
	}
	
}
