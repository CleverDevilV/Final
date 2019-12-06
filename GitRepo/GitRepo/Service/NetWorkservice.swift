//
//  NetWork.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation



//protocol DecodeIntoModelData {
//	var data: [Decodable] {get set}
//	func decodeFromBack()
//}


//protocol NetworkServiceProtocol {
//
//	func get(_ from: Endpoint, completion: @escaping (Result<Data?,Error>) -> Void)
//}
//
//enum HTTPType {
//	case GET
//	case POST
//}
//
//struct Endpoint {
//	var host = "https://api.github.com/user/repos"
	//
	// -> Request
//	var type: HTTPtype
//}

//struct GitBaseResponse: Decodable {
//
//}

//struct Response {
//
//	var gitResponse: GitBaseResponse
//
//
//}

class NetworkService {
	
	private let session: URLSession
	private let token = UserDefaults.standard.get(with: .oauth_access_token)
	
	private var queue = DispatchQueue(label: "RepoQueue", qos: .default, attributes: .concurrent)
	
	
//	init(_ session : URLSession) {
//		self.session = session
//	}
	init() {
		session = URLSession(configuration: .default)
	}
	
	
	
//	public func loadData(stringURL: String, completion: @escaping ([Repo]) -> ()) {
////		let stringURL = "https://api.github.com/user/repos"
//
//		guard let url = URL(string: stringURL) else {
//			print("Not URL")
//			return
//		}
//
//		var request = URLRequest(url: url)
//		request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
//
//		session.dataTask(with: request) {
//			data, response, error in
//
//			guard error == nil else {
//				print("Error: \(error?.localizedDescription ?? "no description")")
//				return
//			}
//
//			guard let data = data else {
//				print("No data")
//				return
//			}
//			do {
//				let text = try? JSONSerialization.jsonObject(with: data, options: [])
//				let repos = try JSONDecoder().decode([RepoFromGit].self, from: data)
//				print(repos.count)
//				var reposFromBack = [Repo]()
//				for repo in repos {
//					let repo = Repo(name: repo.name, repoLink: repo.html_url, languageOfProject: repo.language, collaborators: [], changes: [:], owner: repo.owner.login)
//					reposFromBack.append(repo)
//				}
//				//				completion(.success(reposFromBack))
//				completion((reposFromBack))
//
//			} catch {
//				print(error)
//			}
//
//
//			}.resume()
//	}
	
	
	
}
