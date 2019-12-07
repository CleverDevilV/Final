//
//  Loader.swift
//  GitRepo
//
//  Created by Дарья Витер on 06/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

/** [SourceType](x-source-tag://SourceType) options

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
	func getData(endPoint: EndPointType?, _ completion: @escaping (_ result: Decodable?, _ error: String?) -> () )
}

///Tests - [LoaderTests](x-source-tag://LoaderTests).
final class Loader: LoaderProtocol {
	
	var networkManager: NetworkManagerProtocol!
	var coreDataService: CoreDataServiceProtocol!
	
	init(coreDataService: CoreDataServiceProtocol?) {
		self.coreDataService = coreDataService
	}
	
	enum Result{
		case success(Any)
		case failure(String)
		
	}
	
	/** Get data from different sourece types using endPoints.
	- Parameters:
		- source: value of SourceType
		- endPoint: value of EndPointType
	
	- Returns:
		- result: Decodable?
		- completion: @escaping (_ result: Decodable?, _ error: String?) -> ()
	
	If HTTPHeader field "Content-Type" == nil - setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type").
	*/
	func getBaseDataFrom(source: SourceType?, endPoint: EndPointType?, completion: @escaping (_ result: Decodable?, _ error: String?) -> ()) {
		
		guard let source = source else {return}
		
		guard let endPoint = endPoint else {return}
		
		switch source {
		case .gitHub:
			networkManager = GitHubNetworkManager()
			networkManager.getData(endPoint: endPoint) {
				result, error in
				completion(result, error)
			}
			
		case .firebase:
			networkManager = FirebaseNetworkManager()
			networkManager.getData(endPoint: FirebaseApi.getProjects) {
				result, error in
				completion(result, error)
			}
			
		case .coreData:
			self.coreDataService.getData(endPoint: endPoint) {
				result, error in
				completion(result, error)
			}
		}
	}
	
}
