//
//  NetworkManagerProtocol.swift
//  GitRepo
//
//  Created by Дарья Витер on 04/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// No Unit Tests

protocol NetworkManagerProtocol {
	func getData(endPoint: EndPointType, completion: @escaping (_ result: Decodable?, _ error: String?) -> ())
}
