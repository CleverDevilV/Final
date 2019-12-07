//
//  EndPointTypeProtocol.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

/**
[EndPointTypeProtocol](x-source-tag://EndPointTypeProtocol) Protocol (URL Request + components). Components:
```
var baseURL: URL { get }
var path: String { get }
var httpMethod: HTTPMethod { get }
var task: HTTPTask { get }
var headers: HTTPHeaders? { get }
```
*/
/// - Tag: EndPointTypeProtocol
protocol EndPointType {
	var baseURL: URL { get }
	var path: String { get }
	var httpMethod: HTTPMethod { get }
	var task: HTTPTask { get }
	/// [HTTPHeaders](x-source-tag://HTTPHeaders)
	var headers: HTTPHeaders? { get }
}
