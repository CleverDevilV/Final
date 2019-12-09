//
//  Registration.swift
//  GitRepo
//
//  Created by Дарья Витер on 29/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit
import WebKit

// No Unit Tests

struct OAuthData {
	static let client_id: String = "client_id"
	static let client_secret: String = "client_secret"
	static let scope: String = "scope"
	static let code: String = "code"
	
	let client_id: String
	let client_secret: String
	let scope: String
	let callback_url: String
	var code: String
	
	static let client_id_default: String = "ff276c48e7405f24e856"
	static let client_secret_default: String = "7c23e7bedf426daead370e7cb882e12ef8dcf867"
	static let callback_url_default: String = "gitrepo"
	static let scope_default: String = "repo"
	static let code_default: String = String()
	
	init(client_id: String = client_id_default,
		 client_secret: String = client_secret_default,
		 callback_url: String = callback_url_default,
		 scope: String = scope_default,
		 code: String = code_default) {
		self.client_id = client_id
		self.client_secret = client_secret
		self.scope = scope
		self.callback_url = callback_url
		self.code = code
	}
	
	public mutating func updateCode(with code: String) {
		self.code = code
	}
}

struct OAuthResponse: Codable {
	let access_token: String
	let scope: String
	let token_type: String
}

struct WKNavigationAllowedPath {
	static let login: String = "https://github.com/login"
	static let session: String = "https://github.com/session"
	static let callback: String = OAuthData.callback_url_default
}

class RequestViewController: UIViewController  {
	
	var webView: WKWebView!
	
	private var oauthData: OAuthData = OAuthData()
	
	let session = URLSession(configuration: .default)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		webView = WKWebView(frame: view.frame)
		
		view.addSubview(webView)
		
		setup()
		request()
	}
	
//	override func viewDidAppear(_ animated: Bool) {
//		super.viewDidAppear(animated)
//		
//		
//	}
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		webView.frame = view.frame
	}
	
	private func setup() {
		webView.navigationDelegate = self
	}
	
	private func request() {
		guard var urlComponents = URLComponents(string: "https://github.com/login/oauth/authorize") else { return }
		
		urlComponents.queryItems = [
			URLQueryItem(name: OAuthData.client_id, value: oauthData.client_id),
			URLQueryItem(name: OAuthData.scope, value: oauthData.scope)
		]
		guard let url = urlComponents.url else { return }
		
		let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
		webView.load(request)
	}
	
	private var tokenRequest: URLRequest? {
		guard var urlComponents = URLComponents(string: "https://github.com/login/oauth/access_token") else { return nil }
		
		urlComponents.queryItems = [
			URLQueryItem(name: OAuthData.client_id, value: oauthData.client_id),
			URLQueryItem(name: OAuthData.client_secret, value: oauthData.client_secret),
			URLQueryItem(name: OAuthData.code, value: oauthData.code)
		]
		
		guard let url = urlComponents.url else { return nil }
		var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		
		return request
	}
	
}

extension RequestViewController: WKNavigationDelegate {
	
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		
		if let url = navigationAction.request.url {
			if url.absoluteString.contains(WKNavigationAllowedPath.login) ||
				url.absoluteString.contains(WKNavigationAllowedPath.session) {
				decisionHandler(.allow)
			} else if url.scheme == WKNavigationAllowedPath.callback {
				decisionHandler(.cancel)
				guard let components = URLComponents(string: url.absoluteString) else { return }
				if let code = components.queryItems?.first(where: { $0.name == OAuthData.code })?.value {
//					authVC?.collapseStack()
					oauthData.updateCode(with: code)
					oauthRequest()
				}
			} else {
				decisionHandler(.cancel)
			}
		} else {
			decisionHandler(.cancel)
		}
		
	}
	
//	private func getNameOfUser() {
//		guard let request = tokenRequest else { return }
//	}
	
	private func oauthRequest() {
		guard let request = tokenRequest else { return }
		let task = session.dataTask(with: request) { (data, response, error) in
			guard let response = response as? HTTPURLResponse else { DispatchQueue.main.async { self.showNetworkPerformingAlert(with: error) }; return }
			switch response.statusCode {
			case 200..<300:
				guard let data = data else { return }
				do {
					let response = try JSONDecoder().decode(OAuthResponse.self, from: data)
//					print(response)
					
					
					self.handleOAuthResponse(response: response)
				} catch {
					print("Error while parsing OAuthResponse: \(error.localizedDescription)")
					DispatchQueue.main.async { self.showNetworkPerformingAlert(with: error) }
				}
			default:
				DispatchQueue.main.async { self.showNetworkPerformingAlert(with: error) }
			}
		}
		task.resume()
		
	}
	
	private func showNetworkPerformingAlert(with error: Error?) {
//		if Reachability.isConnectedToNetwork() {
//			self.requestFailedAlert(with: error)
//		} else {
//			self.noConnectionAlert()
//		}
	}
	
	func handleOAuthResponse(response: OAuthResponse) {
		DispatchQueue.main.async {
			UserDefaults.standard.update(with: .oauth_access_token, data: response)
			
			let networkManager = GitHubNetworkManager(with: AppDelegate.shared.session)
			networkManager.getData(endPoint: GitHubApi.user) {
				login, error in
				
				guard let login = login as? String else {return}
				DispatchQueue.main.async {
					UserDefaults.standard.update(with: .oauth_user_login, data: login)
					
					self.dismiss(animated: true, completion: nil)
					AppDelegate.shared.rootViewController.switchToLogout()
				}
				
			}
			
			WebCacheCleaner.clear()
		}
	}
	
	private func noConnectionAlert() {
		let alert = UIAlertController.init(title: "No internet Connection", message: "Cross check your internet connection and try again", preferredStyle: .alert)
//		let actionDecline = UIAlertAction(title: "Decline", style: .cancel) { (_) in self.authVC?.declineAction(nil) }
		let actionRefresh = UIAlertAction(title: "Refresh", style: .default) { (_) in self.oauthRequest() }
//		alert.addAction(actionDecline)
		alert.addAction(actionRefresh)
		present(alert, animated: true, completion: nil)
	}
	
	private func requestFailedAlert(with error: Error?) {
		let message = (error == nil) ? "Development error: make sure\nclient_id and client_secret are set correctly for oauthData property" : "With error: \(error!.localizedDescription)"
		let alert = UIAlertController.init(title: "Oauth request is failed", message: message, preferredStyle: .alert)
//		let actionDecline = UIAlertAction(title: "Decline", style: .cancel) { (_) in self.authVC?.declineAction(nil) }
		let actionRefresh = UIAlertAction(title: "Refresh", style: .default) { (_) in self.oauthRequest() }
//		alert.addAction(actionDecline)
		alert.addAction(actionRefresh)
		present(alert, animated: true, completion: nil)
	}
	
}

final class WebCacheCleaner {
	
	class func clear() {
		URLCache.shared.removeAllCachedResponses()
		
		HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
		print("[WebCacheCleaner] All cookies deleted")
		
		WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
			records.forEach { record in
				WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
				print("[WebCacheCleaner] Record \(record) deleted")
			}
		}
	}
	
}

