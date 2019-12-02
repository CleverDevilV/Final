//
//  NetworkRouter.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ respose: URLResponse?, _ error: Error?) -> ()

// У NetworkRouter есть EndPoint, который он использует для запросов, и как только запрос завершается, результат этого запроса передается в замыкание NetworkRouterCompletion. В протоколе также есть функция cancel, которая может использоваться для прерывания длительных запросов загрузки и выгрузки. Мы также использовали здесь associatedtype, потому что мы хотим чтобы наш Routerподдерживал любой тип EndPointType. Без использования associatedtype роутеру бы пришлось иметь какой-то конкретный тип реализующий EndPointType

protocol NetworkRouter: class {
	associatedtype EndPoint: EndPointType
	
	func request(_ route: EndPoint, complition: @escaping NetworkRouterCompletion)
	func cancel()
}
