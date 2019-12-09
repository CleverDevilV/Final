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
//			print("Data")
			completionHandler(data, nil, error)
			
		})
		return dataTask
	}
}

class URLSessionDataTaskMock: URLSessionDataTask {
	
	private let closure: () -> Void
	
	/// Init with Data Task a closure.
	init(closure: @escaping () -> Void) {
		self.closure = closure
	}
	
	/// When call 'resume' - call init closure
	override func resume() {
		closure()
	}
}

