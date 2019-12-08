//
//  URLParameterEncoder.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit Tests

/**
Structure for creating a URLRequest based on  [Parameters](x-source-tag://Parameters). If HTTPHeader field "Content-Type" == nil - setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type").
 Tests - [URLParameterEncoderTests](x-source-tag://URLParameterEncoderTests).
*/
public struct URLParameterEncoder: ParameterEncoder {
	
	/**
	Encoding URL - [parameters](x-source-tag://Parameters).
	
	- Parameters:
		- urlRequest: **inout** URLRequest for change with parameters.
		- parameters: Parameters of URLRequest
	
	If HTTPHeader field "Content-Type" == nil - setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type").
	*/
	
	public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
		
		guard let url = urlRequest.url else { throw NetworkError.missingURL }
		
		if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), parameters.isEmpty {
			urlComponents.queryItems = [URLQueryItem]()
			
			for (key, value) in parameters {
				let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
				urlComponents.queryItems?.append(queryItem)
			}
			urlRequest.url = urlComponents.url
		}
		if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
			urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
		}
	}
	
}
