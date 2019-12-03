//
//  HTTPTask.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String : String]

// конфигурация параметров определенного запроса
public enum HTTPTask {
	case request
	
	case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
	
	case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
	
	case uploadData(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?, uploadData: [String : [ProjectForUploadToBack]])
	
}
