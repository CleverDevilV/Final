//
//  NetWork.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

struct RepoFromGit: Codable {
	var id: Int
	var name: String
	var url: String
	var language: String?
	var owner: Owner
	
	struct Owner: Codable {
		var login: String
	}
	
}

protocol DecodeIntoModelData {
	var data: [Decodable] {get set}
	func decodeFromBack()
}

class NetworkService {
	
	private let session: URLSession
	private let token = UserDefaults.standard.get(with: .oauth_access_token)
	
	private var queue = DispatchQueue(label: "RepoQueue", qos: .default, attributes: .concurrent)
	
	
	init() {
		session = URLSession(configuration: .default)
	}
	
	
	
	public func loadData(stringURL: String, completion: @escaping ([Repo]) -> ()) {
//		let stringURL = "https://api.github.com/user/repos"
		
		guard let url = URL(string: stringURL) else {
			print("Not URL")
			return
		}
		
		var request = URLRequest(url: url)
		request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
		
		session.dataTask(with: request) {
			data, response, error in
			
			guard error == nil else {
				print("Error: \(error?.localizedDescription ?? "no description")")
				return
			}
			
			guard let data = data else {
				print("No data")
				return
			}
			do {
				let repos = try JSONDecoder().decode([RepoFromGit].self, from: data)
				print(repos.count)
				var reposFromBack = [Repo]()
				for repo in repos {
					let repo = Repo(name: repo.name, repoLink: repo.url, languageOfProject: repo.language, collaborators: [], changes: [:], owner: repo.owner.login)
					reposFromBack.append(repo)
				}
				//				completion(.success(reposFromBack))
				completion((reposFromBack))
				
			} catch {
				print(error)
			}
			
			
			}.resume()
	}
}
