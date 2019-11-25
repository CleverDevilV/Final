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
	
}

class NetworkService {
	
	let session: URLSession
	
	private var queue = DispatchQueue(label: "RepoQueue", qos: .default, attributes: .concurrent)
	
	
	init() {
		session = URLSession(configuration: .default)
	}
	
	public func loadData(completion: @escaping (Result<String, Error>) -> ()) {
		
		guard let url = URL(string: "https://api.github.com/users/CleverDevilV/repos") else {
			print("Not URL")
			return
		}
		
		var request = URLRequest(url: url)
		//		request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
		
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
				completion(.success(repos[0].name))
				
			} catch {
				print(error)
			}
			
			
			}.resume()
	}
}
