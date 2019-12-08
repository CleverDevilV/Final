//
//  NetworkRouterProtocol.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// No Unit Tests

/// TypeAlias for (_ data: Data?, _ respose: URLResponse?, _ error: Error?) -> ()
public typealias NetworkRouterCompletion = (_ data: Data?, _ respose: URLResponse?, _ error: Error?) -> ()

/// Protocol for getting data from request or cancel dataTask
protocol NetworkRouter: class {
	associatedtype EndPoint: EndPointType
	
	/// Get data from request
	func request(_ route: EndPoint, complition: @escaping NetworkRouterCompletion)
	/// Cancel request
	func cancel()
}
