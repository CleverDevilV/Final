//
//  GitHubEndPoint.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

//enum GitHubNetworkEnvironment {
//	case user
//	case repo
//}

/**
GitHubApi options.

````
/// for get user info
case user
/// for get repos
case repos
/// for get information about concrete repository
case oneRepo(url: String)
/// for get array of collaborators
case collaborators(url: String)

````
*/

public enum GitHubApi {
	
	/// for get user info
	case user
	/// for get repos
	case repos
	/// for get information about concrete repository
	case oneRepo(url: String)
	/// for get array of collaborators
	case collaborators(url: String)
	/// for get array of branches
	case branches(url: String)
	
	case commits(url: String)
	
	case oneCommit(url: String)
}

extension GitHubApi: EndPointType {
	
	// ?
//	var differentBaseURLs: String {
//		switch GitHubNetworkEnvironment {
//		case .user: return ""
//		case .repo: return ""
//		}
//	}
	
	/// Base URL for connecting GitHub : https://api.github.com/user
	var baseURL: URL {
		switch self {
		case .oneRepo:
			let userName = UserDefaults.standard.get(with: .oauth_user_login)
			guard let url = URL(string: "https://api.github.com/repos/\(userName)") else {fatalError("baseURL could not be configured")}
			return url
//			guard let url = URL(string: stringUrl) else {fatalError("baseURL could not be configured")}
//			return url
		case .collaborators(let url):
			let trimmedUrl = url.replacingOccurrences(of: "{/collaborator}", with: "")
			guard let url = URL(string: trimmedUrl) else { fatalError("baseURL could not be configured") }
			return url
		case .branches(let url):
			let trimmedUrl = url.replacingOccurrences(of: "{/branch}", with: "")
			guard let url = URL(string: trimmedUrl) else { fatalError("baseURL could not be configured") }
			return url
		case .commits(let url):
//			let trimmedUrl = url.replacingOccurrences(of: "{/branch}", with: "") 
			guard let url = URL(string: url) else { fatalError("baseURL could not be configured") }
			return url
		case .oneCommit(let url):
			guard let url = URL(string: url) else { fatalError("baseURL could not be configured") }
			return url
		default:
			guard let url = URL(string: "https://api.github.com/user") else {fatalError("baseURL could not be configured")}
			return url
		}
	}
	
	/// Path to adding for **baseURL**
	var path: String {
		switch self {
			/// Path to user login
		case .user: return ""
			/// Path to users repositories
		case .repos: return "/repos"
		case .oneRepo(let repoName): return "/\(repoName)"
		case .collaborators(_ ): return ""
		case .branches(_ ): return ""
		case .commits(_ ): return ""
		case .oneCommit(_ ): return ""
		}
	}
	
	/// Http Get Method
	var httpMethod: HTTPMethod {
		return .get
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
		let token = UserDefaults.standard.get(with: .oauth_access_token)
		let header = HTTPHeaders(dictionaryLiteral: ("Authorization", "token \(token)"))
		return header
	}
	
	
}
