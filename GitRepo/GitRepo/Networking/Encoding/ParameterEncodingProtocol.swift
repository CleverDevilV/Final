//
//  ParameterEncoding.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

/// Typealias for parameters dictionary
/// - Tag: Parameters
public typealias Parameters = [String : Any]

public protocol ParameterEncoder {
	
	/**
	Func for encode [Parameters](x-source-tag://Parameters).
	- Parameters:
		- urlRequest: **inout** URLRequest for change with parameters.
		- parameters: Parameters of URLRequest
	*/
	static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

/**
Network error enum.

````
case parametersNil: "Parameters were nil"
case encodingFailed: "Parameter encoding failed"
case missingURL: "URL is nil"
````
*/
public enum NetworkError: String, Error {
	case parametersNil  = "Parameters were nil"
	case encodingFailed = "Parameter encoding failed"
	/// Mising
	case missingURL     = "URL is nil"
}
