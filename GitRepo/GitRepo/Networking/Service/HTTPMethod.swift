//
//  HTTPMethod.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// No Unit Tests

/**
[HTTPMethod](x-source-tag://HTTPMethod) enum.
```
case get    = "GET"
case post   = "POST"
case put    = "PUT"
case patch  = "PATCH"
case delete = "DELETE"
```
*/
/// - Tag: HTTPMethod
public enum HTTPMethod: String {
	case get    = "GET"
	case post   = "POST"
	case put    = "PUT"
 	case patch  = "PATCH"
	case delete = "DELETE"
}
