//
//  RepositoriesBase.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

final class RepositoriesBase {
	
	func copy(with zone: NSZone? = nil) -> Any {
		return self
	}
	
	private (set) var repositories: [Repository] = []
	private (set) var userName: String = UserDefaults.standard.get(with: .oauth_user_login)
	
	
	init(with data: Data?) {
		if let data = data {
			decodeRepositories(data)
		}
	}
	
	init(with repositories: [Repository]?) {
		if let repositories: [Repository] = repositories {
			self.repositories = repositories
		}
	}
	
	private func decodeRepositories(_ data: Data) {
		do {
			let newResponse = try JSONDecoder().decode([Repository].self, from: data)
			self.repositories = newResponse
			
		} catch {
			print(error)
		}
	}
}
