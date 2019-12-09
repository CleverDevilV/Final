//
//  FirebaseNetworkManager.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit tests

 /// Unit Tests - [FirebaseNetworkManagerTests](x-source-tag://FirebaseNetworkManagerTests)
struct FirebaseNetworkManager: NetworkManagerProtocol {
	
	private let router: Router<FirebaseApi>!
	
	enum Result<String> {
		case success
		case failure(String)
	}
	
	init(with session: URLSession) {
		self.router = Router<FirebaseApi>(with: session)
	}
	
	fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
		switch response.statusCode {
		case 200 ... 299: return .success
		case 402 ... 500: return .failure(GitHubNetworkResponse.authentificationError.rawValue)
		case 501 ... 599: return .failure(GitHubNetworkResponse.badRequest.rawValue)
		case 600: return .failure(GitHubNetworkResponse.outdated.rawValue)
		default: return .failure(GitHubNetworkResponse.failed.rawValue)
			
		}
	}
	/// Get Decodable data from EndPointType.
	func getData(endPoint: EndPointType, completion: @escaping (_ result: Decodable?, _ error: String?) -> ()) {
		guard let endPoint = endPoint as? FirebaseApi else {
			completion(nil, "Unknown end point")
			return
			
		}
		router.request(endPoint) { data, response, error in
			if error != nil {
				completion(nil, "Plese check your network connection")
			}
			
			if let response = response as? HTTPURLResponse {
				let result = self.handleNetworkResponse(response)
				switch result {
				case .success:
					guard let responseData = data else {
						completion(nil, GitHubNetworkResponse.noData.rawValue)
						return
					}
					
					do {
//						let text = try? JSONSerialization.jsonObject(with: responseData, options: [])
						switch endPoint {
						case .getProjects:
							let projects = ProjectsBase(with: responseData)
							completion(projects, nil)
							
						case .uploadProjects:
							completion(true, nil)
							
						case .oneProject( _):
							let newResponse = try JSONDecoder().decode(Repository.self, from: responseData)
							completion(newResponse, nil)
						}
						
					} catch {
						completion(nil, GitHubNetworkResponse.unabledToDecode.rawValue)
					}
					
				case .failure(let networkFailureError):
					completion(nil, networkFailureError)
				}
			}
		}
	}
}
