//
//  FirebaseEndPoint.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

//enum GitHubNetworkEnvironment {
//	case user
//	case repo
//}

/**
FirebaseApi options.

````
case getProjects
case uploadProjects
case oneProject(url: String)
````
*/

public enum FirebaseApi {
	
	/// for get user info
	case getProjects
	/// for get repos
	case uploadProjects
	/// for get information about concrete repository
	case oneProject(url: String)
}

extension FirebaseApi: EndPointType {
	
	// ?
	//	var differentBaseURLs: String {
	//		switch GitHubNetworkEnvironment {
	//		case .user: return ""
	//		case .repo: return ""
	//		}
	//	}
	
	/// Base URL for connecting Firebase : https://finalproject-sb.firebaseio.com/Projects
	var baseURL: URL {
		switch self {
		default:
			let apiKey = UserDefaults.standard.get(with: .firebase_apiKey)
			guard let url = URL(string: "https://final-project-sb.firebaseio.com/projects.json?avvrdd_token=\(apiKey)") else {fatalError("baseURL could not be configured")}
			return url
		}
	}
	
	/// Path to adding for **baseURL**
	var path: String {
		switch self {
		/// Path to uploadProjects
		case .uploadProjects: return ""
		/// Path to get projects
		default : return ""
		}
	}
	
	/// Http Get Method
	var httpMethod: HTTPMethod {
		switch self {
		case .uploadProjects:
			return .put
		default:
			return .get
		}
	}
	
	/**
	
	Choosing HttpTask
	
	-Parameters:
	- token: from UserDefaults.standard
	- HttpTask: type of request
	
	*/
	var task: HTTPTask {
		return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionHeaders: self.headers)
	}
	
	/// HttpHeaders for Auth at GitHub
	var headers: HTTPHeaders? {
//		let token = UserDefaults.standard.get(with: .oauth_access_token)
//		let header = HTTPHeaders(dictionaryLiteral: ("Authorization", "token \(token)"))
		return nil
	}
	
	
}
