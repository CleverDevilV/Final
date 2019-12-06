//
//  JSONParameterEncoder.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Все аналогично как и в случае с URLParameter, просто здесь мы преобразуем параметры для JSON и опять же добавляем параметры, определяющие кодировку «application/json», в хедер.


public struct JSONParameterEncoder: ParameterEncoder {
	
	/**
	Encoding JSON - [parameters](x-source-tag://Parameters).
	- Parameters:
		- urlRequest: **inout** URLRequest for change with parameters.
		- parameters: Parameters of URLRequest
	
	If HTTPHeader field "Content-Type" == nil - setValue("application/json", forHTTPHeaderField: "Content-Type").
	*/
	public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
		
		guard urlRequest.url != nil else { throw NetworkError.missingURL }
		
		do {
			let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
			urlRequest.httpBody = jsonAsData
			if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
				urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
			}
		} catch {
			throw NetworkError.encodingFailed
		}
	}
	
	
}
