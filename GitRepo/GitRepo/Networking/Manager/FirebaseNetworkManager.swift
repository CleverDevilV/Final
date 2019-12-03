//
//  FirebaseNetworkManager.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

struct FirebaseNetworkManager {
	
	private let router = Router<FirebaseApi>(with: URLSession.init(configuration: .default))
	
	enum Result<String> {
		case success
		case failure(String)
	}
	
	fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
		switch response.statusCode {
		case 200 ... 299: return .success
		case 402 ... 500: return .failure(GitHubNetworkResponse.authentificationError.rawValue)
		case 501 ... 599: return .failure(GitHubNetworkResponse.badRequest.rawValue)
		case 600: return .failure(GitHubNetworkResponse.outdated.rawValue)
		default: return .failure(GitHubNetworkResponse.failed.rawValue)
			
		}
	}
	
	// 1. Мы определяем метод getNewMovies с двумя аргументами: номер страницы пагинации и completion handler, который возвращает опциональный массив моделей Movie, либо опциональную ошибку.
	//
	//	2. Вызываем Router. Передаем номер страницы и обрабатываем completion в замыкании.
	//
	//	3. URLSession возвращает ошибку если нет сети или не получилось сделать запрос по какой-либо причине. Обратите внимание, что это не ошибка API, такие ошибки происходят на клиенте и происходят обычно из-за плохого качества интернет-соединения.
	//
	//	4. Нам необходимо привести наш response к HTTPURLResponse, потому что нам надо получить доступ к свойству statusCode.
	//
	//	5. Объявляем result и инициализируем его с помощью метода handleNetworkResponse
	//
	//	6. Success означает что запрос прошел успешно и мы получили ожидаемый ответ. Затем мы проверяем, пришли ли с ответом данные, и если нет, то просто завершаем метод через return.
	//
	//	7. Если же ответ приходит с данными, то необходимо распарсить полученные данные в модель. После этого передаем полученный массив моделей в completion.
	//
	//	8. В случае ошибки просто передаем ошибку в completion.
	
	func getFirebaseData(endPoint: EndPointType?, completion: @escaping (_ movie: Any?, _ error: String?) -> ()) {
		guard let endPoint = endPoint as? FirebaseApi else {
			completion(nil, "Unknown end point")
			return
			
		}
		router.request(endPoint) { data, response, error in
			if error != nil {
				completion(nil, "Plese check your network connection")
			}
			
			if let response = response as? HTTPURLResponse {
				let result = self.handleNetworkResponse(response)
				switch result {
				case .success:
					guard let responseData = data else {
						completion(nil, GitHubNetworkResponse.noData.rawValue)
						return
					}
					
					do {
						let text = try? JSONSerialization.jsonObject(with: responseData, options: [])
						switch endPoint {
						case .getProjects:
							let apiResponse = try JSONDecoder().decode([String : [String:Project]].self, from: responseData)
							completion(apiResponse, nil)
						case .uploadProjects:
							let newResponse = try JSONDecoder().decode([Repository].self, from: responseData)
							completion(newResponse, nil)
						case .oneProject(let url):
							let newResponse = try JSONDecoder().decode(Repository.self, from: responseData)
							completion(newResponse, nil)
						}
						
					} catch {
						completion(nil, GitHubNetworkResponse.unabledToDecode.rawValue)
					}
					
				case .failure(let networkFailureError):
					completion(nil, networkFailureError)
				}
			}
		}
	}
}
