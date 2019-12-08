//
//  MockUrlSession.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

class MockUrlSession: URLSession {
	
	
	
	override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		let dataTask = URLSessionDataTaskMock(closure: {
//			(data, response, error) in
			let data = "data".data(using: .utf8)
			let error: Error = NetworkError.missingURL
			print("Data")
			completionHandler(data, nil, error)
			
		})
		return dataTask
	}
}

class URLSessionDataTaskMock: URLSessionDataTask {
	
	private let closure: () -> Void
	
	// We have to give the Data Task a closure on initialization.
	init(closure: @escaping () -> Void) {
		self.closure = closure
	}
	
	// We override the 'resume' method and simply call our closure
	// instead of actually resuming any task.
	override func resume() {
		closure()
	}
}

