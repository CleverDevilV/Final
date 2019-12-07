//
//  HTTPTask.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

/// - Tag: HTTPHeaders
public typealias HTTPHeaders = [String : String]

/**
Enum of parameters for create requests.
[HTTPTask](x-source-tag://HTTPTask)
```
case request
case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
case uploadData(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?, uploadData: [String : [ProjectForUploadToBack]])
```
*/
/// - Tag: HTTPTask
public enum HTTPTask {
	case request
	
	case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
	
	case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
	
	case uploadData(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?, uploadData: [String : [ProjectForUploadToBack]])
	
}
