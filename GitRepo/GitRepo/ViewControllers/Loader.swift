//
//  Loader.swift
//  GitRepo
//
//  Created by Дарья Витер on 06/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

enum SourceType {
	case gitHub
	case firebase
	case coreData
}

protocol CoreDataServiceProtocol {
	
}

final class Loader: LoaderProtocol {
	
	private var networkManager: NetworkManagerProtocol!
	private let coreDataService: CoreDataServiceProtocol!
	
	init(coreDataService: CoreDataServiceProtocol?) {
		self.coreDataService = coreDataService
	}
	
	enum Result{
		case success(Any)
		case failure(String)
		
	}
	
	func getBaseDataFrom(source: SourceType, completion: @escaping (_ result: Any?, _ error: String?) -> ()) {
		switch source {
		case .gitHub:
			networkManager = GitHubNetworkManager()
		case .firebase:
			networkManager = FirebaseNetworkManager()
			networkManager.getData(endPoint: FirebaseApi.getProjects) {
				result, error in
				completion(result, error)
			}
		case .coreData:
			break
		}
	}
	
}
