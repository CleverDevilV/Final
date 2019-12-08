//
//  Router.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit tests ???

/**
Class for create Request and get NetworkRouterCompletion as (_ data: Data?, _ respose: URLResponse?, _ error: Error?) -> ()
*/
class Router <EndPoint: EndPointType>: NetworkRouter {
	
	private var task: URLSessionTask?
	private let session: URLSession?
	
	init(with session: URLSession) {
		self.session = session
	}
	
	/// Create URLSessionRequest and pass NetworkRouterCompletion as (_ data: Data?, _ respose: URLResponse?, _ error: Error?) -> ()
	func request(_ route: EndPoint, complition: @escaping NetworkRouterCompletion) {
	
		do {
			let request = try self.buildRequest(from: route)
			task = self.session?.dataTask(with: request, completionHandler: { data, response, error in
				complition(data, response, error)
			})
		} catch {
			complition(nil, nil, error)
		}
		self.task?.resume()
	}
	
	func cancel() {
		self.task?.cancel()
	}
	
	/// Builer for request
	fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
		var url = route.baseURL.appendingPathComponent(route.path)
		if route.path == "" {
			url = route.baseURL.appendingPathExtension(route.path)
		}
		
		var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
		
		request.httpMethod = route.httpMethod.rawValue
		
		do {
			switch route.task {
			case .request:
				request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			case .requestParameters(let bodyParameters, let urlParameters) :
				try self.configureParameters(bodyParameters: bodyParameters,
											 urlParameters: urlParameters,
											 request: &request)
				
			case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionHeaders):
				self.addAdditionalHeaders(additionHeaders, request: &request)
				try self.configureParameters(bodyParameters: bodyParameters,
											 urlParameters: urlParameters,
											 request: &request)
			case .uploadData(let bodyParameters, let urlParameters, let additionHeaders, let data):
				self.addAdditionalHeaders(additionHeaders, request: &request)
				try self.configureParameters(bodyParameters: bodyParameters,
											 urlParameters: urlParameters,
											 request: &request)
				do {
					let uploadData = try JSONEncoder().encode(data)
					request.httpBody = uploadData
				} catch {
					print(error)
				}
			}
			return request
		} catch {
			throw error
		}
	}
	
	/// Add parameters to request
	fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
		
		do {
			if let bodyParameters = bodyParameters {
				try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
			}
			if let urlParameters = urlParameters {
				try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
			}
		} catch {
			throw error
		}
	}
	
	/// Add headers to request
	fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
		guard let headers = additionalHeaders else { return }
		
		for (key, value) in headers {
			request.setValue(value, forHTTPHeaderField: key)
		}
	}
}
