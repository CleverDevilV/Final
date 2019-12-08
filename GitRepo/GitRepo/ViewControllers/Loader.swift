//
//  Loader.swift
//  GitRepo
//
//  Created by Дарья Витер on 06/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit Tests

/** [SourceType](x-source-tag://SourceType) options.

````
/// Use GitHubNetworkManager
case gitHub
/// Use FirebaseNetworkManager
case firebase
/// Use CoreDataManager
case coreData
````
*/
/// - Tag: SourceType
enum SourceType {
	/// Use GitHubNetworkManager
	case gitHub
	/// Use FirebaseNetworkManager
	case firebase
	/// Use CoreDataManager
	case coreData
}

protocol CoreDataServiceProtocol {
	func getData(baseType: BaseType, _ completion: @escaping (_ result: Decodable?, _ error: String?) -> () )
}

/**
Service for load Data from Back and CoreData.
Tests - [LoaderTests](x-source-tag://LoaderTests).
*/
final class Loader: LoaderProtocol {
	
	var githubNetworkManager: NetworkManagerProtocol!
	var firebaseNetworkManager: NetworkManagerProtocol!
	var coreDataService: CoreDataServiceProtocol!
	
	init(githubNetworkManager: NetworkManagerProtocol?, firebaseNetworkManager: NetworkManagerProtocol?, coreDataService: CoreDataServiceProtocol?) {
		self.githubNetworkManager = githubNetworkManager
		self.firebaseNetworkManager = firebaseNetworkManager
		
		self.coreDataService = coreDataService
		
	}
	
	enum Result{
		case success(Any)
		case failure(String)
		
	}
	
	/** Get data from different sourece types using endPoints.
	
	If HTTPHeader field "Content-Type" == nil - setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type").
	*/
	func getBaseDataFrom(source: SourceType, endPoint: EndPointType?, baseType: BaseType?, completion: @escaping (_ result: Decodable?, _ error: String?) -> ()) {
		
		switch source {
		case .gitHub:
			guard let endPoint = endPoint else {return}
			
			githubNetworkManager.getData(endPoint: endPoint) {
				result, error in
				
				completion(result, error)
			}
			
		case .firebase:
			guard let endPoint = endPoint else {return}
			
			firebaseNetworkManager.getData(endPoint: FirebaseApi.getProjects) {
				result, error in
				
				completion(result, error)
			}
			
		case .coreData:
			guard let baseType = baseType else {return}
			self.coreDataService.getData(baseType: baseType) {
				result, error in
				
				completion(result, error)
			}
		}
	}
	
}
