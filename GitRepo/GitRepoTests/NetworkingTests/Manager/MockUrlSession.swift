//
//  MockUrlSession.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

class MockUrlSession: URLSession {
	override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		let task: URLSessionDataTask = dataTask(with: url, completionHandler: {
			(data:Data?, response:URLResponse?, error:Error?) in completionHandler(data,response,error) }) as URLSessionDataTask
		return task
	}
}
