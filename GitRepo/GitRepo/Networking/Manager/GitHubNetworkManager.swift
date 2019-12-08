//
//  GitHubNetworkManager.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit tests ???

struct GitHubNetworkManager: NetworkManagerProtocol {
	
	private let router: Router<GitHubApi>!
	
	private var queue = DispatchQueue(label: "com.sber.final", qos: .default, attributes: .concurrent)
	
	enum Result<String> {
		case success
		case failure(String)
	}
	
	init(with session: URLSession) {
		self.router = Router<GitHubApi>(with: session)
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
	public func getData(endPoint: EndPointType, completion: @escaping (_ result: Decodable?, _ error: String?) -> ()) {
		guard let endPoint = endPoint as? GitHubApi else {
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
						case .user:
							let apiResponse = try JSONDecoder().decode(User.self, from: responseData)
							completion(apiResponse.login, nil)
						case .repos:
							let repositories = RepositoriesBase(with: responseData)
							
							self.queue.async {
								let myGroup = DispatchGroup()
								for repositiry in repositories.repositories {
									myGroup.enter()
									self.getData(endPoint: GitHubApi.collaborators(repositoryName: repositiry.collaboratorsLink ?? "")) {
										result, error in
										
										DispatchQueue.main.async {
											repositiry.collaborators = result as? [User]
//											print("Loaded collaborators at \(repositiry.name)")
											if repositiry.branches != nil, repositiry.commits != nil {
												myGroup.leave()
//												print("leave")
											}
										}
									}
//
									self.getData(endPoint: GitHubApi.branches(repositoryName: repositiry.branchesLink ?? "")) {
										result, error in
										
										DispatchQueue.main.async {
											repositiry.branches = result as? [Branch]
//											print("Loaded branches at \(repositiry.name)")
											if repositiry.collaborators != nil, repositiry.commits != nil {
												myGroup.leave()
//												print("leave")
											}
										}
									}
									
									self.getData(endPoint: GitHubApi.commits(repositoryName: repositiry.changes ?? "")) {
										result, error in
										
										DispatchQueue.main.async {
											var commitsArray = [Commit]()
											let events = result as? [Event]
											for event in events ?? [] {
												if let commits : [Commit] = event.payload.commits {
													for commit in commits {
														var commit = commit
														commit.date = event.created_at
														commitsArray.append(commit)
													}
												}
											}
											repositiry.commits = commitsArray
											
											if repositiry.collaborators != nil, repositiry.branches != nil {
												myGroup.leave()
											}
										}
									}
								}
								myGroup.notify(queue: DispatchQueue.main) {
									print("End Loading Repositories Base")
									completion(repositories, nil)
								}
							}
							
						case .oneRepo:
							let newResponse = try JSONDecoder().decode(Repository.self, from: responseData)
							
							self.queue.async {
								let myGroup = DispatchGroup()
								
								myGroup.enter()
								self.getData(endPoint: GitHubApi.collaborators(repositoryName: newResponse.collaboratorsLink ?? "")) {
									result, error in
									
									DispatchQueue.main.async {
										newResponse.collaborators = result as? [User]
										if newResponse.branches != nil, newResponse.commits != nil {
											myGroup.leave()
										}
									}
								}
								
								self.getData(endPoint: GitHubApi.branches(repositoryName: newResponse.branchesLink ?? "")) {
									result, error in
									
									DispatchQueue.main.async {
										newResponse.branches = result as? [Branch]
										if newResponse.collaborators != nil, newResponse.commits != nil {
											myGroup.leave()
										}
									}
								}
								
								self.getData(endPoint: GitHubApi.commits(repositoryName: newResponse.changes ?? "")) {
									result, error in
									
									DispatchQueue.main.async {
										var commitsArray = [Commit]()
										let events = result as? [Event]
										for event in events ?? [] {
											if let commits : [Commit] = event.payload.commits {
												for commit in commits {
													var commit = commit
													commit.date = event.created_at
													commitsArray.append(commit)
												}
											}
										}
										newResponse.commits = commitsArray
										if newResponse.collaborators != nil, newResponse.branches != nil {
											myGroup.leave()
										}
									}
								}
								myGroup.notify(queue: DispatchQueue.main) {
									print("End Loading Repositories Base")
									completion(newResponse, nil)
								}
							}
							
						case .collaborators(_ ):
							let newResponse = try JSONDecoder().decode([User].self, from: responseData)
							completion(newResponse, nil)
							
						case .branches(_ ):
							let newResponse = try JSONDecoder().decode([Branch].self, from: responseData)
							completion(newResponse, nil)
							
						case .commits(_ ):
							
							var newResponse: [Event]?
							do {
								newResponse = try JSONDecoder().decode([Event].self, from: responseData)
							} catch {
								print(error)
							}
							completion(newResponse, nil)
							
						case .oneCommit(_ ):
							var newResponse: Commit?
							do {
								newResponse = try JSONDecoder().decode(Commit.self, from: responseData)
							} catch {
								print(error)
							}
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

/// Enum for response processing
enum GitHubNetworkResponse: String {
	case success
	case authentificationError = "You need to be auth first"
	case badRequest = "Bad request"
	case outdated = "The url requesr outdated"
	case failed = "Network request failed"
	case noData = "Response with no data"
	case unabledToDecode = "We could not decode"
}
