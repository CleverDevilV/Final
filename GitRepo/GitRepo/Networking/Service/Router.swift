//
//  Router.swift
//  GitRepo
//
//  Created by Дарья Витер on 01/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

class Router <EndPoint: EndPointType>: NetworkRouter {
	private var task: URLSessionTask?
	private let session: URLSession?
	
	init(with session: URLSession) {
		self.session = session
	}
	
	// Тут мы создаем URLSession с помощью URLSession.shared, это самый простой способ создания. Но помните, что этот способ не единственный. Можно использовать и более сложные конфигурации URLSession, которые могут менять ее поведение
	
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
	
	// Мы создаем наш запрос с помощью функции buildRequest. Эта функция отвечает за всю жизненно важную работу в нашем сетевом слое. По сути, конвертирует EndPointType в URLRequest. И как только EndPoint превращается в запрос, мы можем передать его в session. Здесь происходит много всего, поэтому давайте разберем по методам. Сначала разберем метод buildRequest:
	
//	1. Мы инициализируем переменную запроса URLRequest. Задаем в ней наш базовый URL-адрес и добавляем к нему путь конкретного запроса, который будет использоваться.
//
//	2. Присваиваем request.httpMethod http-метод из нашего EndPoint.
//
//	3. Создаем блок do-try-catch, потому что наши кодировщики могут выдавать ошибку. Создавая один большой блок do-try-catch мы избавляем себя от необходимости создавать отдельный блок для каждого try.
//
//	4. В switch проверяем route.task.
//
//	5. В зависимости от вида task вызываем соответствующий кодировщик.
	
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
	
	// Эта функция отвечает за преобразование наших параметров запроса. Поскольку наш API предполагает использование bodyParameters в виде JSON и URLParameters преобразованными в формат URL, то мы просто передаем соответствующие параметры в соответствующие функции преобразования, которые мы описывали в начале статьи
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
	
	// Добавляем необходимые заголовки в запрос
	fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
		guard let headers = additionalHeaders else { return }
		
		for (key, value) in headers {
			request.setValue(value, forHTTPHeaderField: key)
		}
	}
}
