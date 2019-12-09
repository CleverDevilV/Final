//
//  Mock.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

class SpyLogoutCommand: LogOutCommand {
	
	var log: String?
	
	override func logOut() {
		log = "log out command"
	}
}

class MockLoader: LoaderProtocol {
	var coreDataService: CoreDataServiceProtocol!
	var log: String?
	
	init() {
		self.log = "loader created"
	}
	
	func getBaseDataFrom(source: SourceType, endPoint: EndPointType?, baseType: BaseType?, completion: @escaping (Decodable?, String?) -> ()) {
		completion("result", nil)
	}
}
