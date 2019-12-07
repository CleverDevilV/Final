//
//  FirebaseEndPoint.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

/**
[FirebaseApi](x-source-tag://GitHubApi) options.
Tests - [FirebaseApiTests](x-source-tag://URLParameterEncoderTests).

````
/// for get user info
case getProjects
/// for get repos
case uploadProjects(data: [String : [ProjectForUploadToBack]]?)
/// for get information about concrete repository
case oneProject(url: String?)
````
*/
/// - Tag: FirebaseApi
public enum FirebaseApi {
	
	/// for get user info
	case getProjects
	/// for get repos
	case uploadProjects(data: [String : [ProjectForUploadToBack]]?)
	/// for get information about concrete repository
	case oneProject(url: String?)
}

extension FirebaseApi: EndPointType {
	
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
		switch self {
		case .uploadProjects(let data):
			return .uploadData(bodyParameters: nil, urlParameters: nil, additionHeaders: self.headers, uploadData: data!)
		default:
			return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionHeaders: self.headers)
		}
	}
	
	/// HttpHeaders for Auth at GitHub
	var headers: HTTPHeaders? {
		
		return nil
	}
	
	
}
