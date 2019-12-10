//
//  RepositoriesBase.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit tests

/**
Base for repositories. User name gets from UserDefaults.standard.
Unit Tests - [RepositoriesBaseTests](x-source-tag://RepositoriesBaseTests)
```
private (set) var repositories: [Repository]
private (set) var userName: String
```
*/
/// - Tag: RepositoriesBase
final class RepositoriesBase: Decodable {
	
	private (set) var repositories: [Repository] = []
	private (set) var userName: String = UserDefaults.standard.get(with: .oauth_user_login)
	
	
	init(with data: Data?) {
		if let data = data {
			decodeRepositories(data)
		}
	}
	
	init(with repositories: [Repository]?) {
		if let repositories: [Repository] = repositories {
			self.repositories = repositories.sorted{(repository1 ,repository2) in
				if let date1 = repository1.lastChange, let date2 = repository2.lastChange {
					return date1 > date2
				}
				return false
			}
		}
	}
	
	private func decodeRepositories(_ data: Data) {
		do {
			let newResponse = try JSONDecoder().decode([Repository].self, from: data)
			
			self.repositories = newResponse.sorted{(repository1 ,repository2) in
				if let date1 = repository1.lastChange, let date2 = repository2.lastChange {
					return date1 > date2
				}
				return false
			}
			
			
		} catch {
			print(error)
		}
	}
}
