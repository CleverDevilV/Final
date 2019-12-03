//
//  UserDef.swift
//  GitRepo
//
//  Created by Дарья Витер on 29/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

enum UserDefaultsKeys : String {
	case permission_denied
	case access_token
	case login
	case firebase_apiKey = "AIzaSyC5e_n2lvpzIxoT3ZASjE6ZQXrE35_ou-o"
}

enum UserDefaultsType : String {
	case oauth_permission_denied
	case oauth_access_token
	case oauth_user_login
	case firebase_apiKey
}

extension UserDefaults {
	
	func update(with type: UserDefaultsType, data: Any?) {
		switch type {
		case .oauth_permission_denied:
			guard let permission_status = data as? Bool else { return }
			set(permission_status, forKey: UserDefaultsKeys.permission_denied.rawValue)
		case .oauth_access_token:
			guard let oauth = data as? OAuthResponse else { return }
			set(oauth.access_token, forKey: UserDefaultsKeys.access_token.rawValue)
			print("token updated, token = ", oauth.access_token)
		default:
			return
		}
	}
	
	func setupLogin(with type: UserDefaultsType, data: String?) {
		guard let login = data else {return}
		set(login, forKey: UserDefaultsKeys.login.rawValue)
		print("login updated, login = ", login)
	}
	
	func get(with type: UserDefaultsType) -> String {
		switch type {
		case .oauth_permission_denied:
			return String()
		case .oauth_access_token:
			return (string(forKey: UserDefaultsKeys.access_token.rawValue) ?? String())
		case .oauth_user_login:
			return (string(forKey: UserDefaultsKeys.login.rawValue) ?? String())
		case .firebase_apiKey:
			return "AIzaSyC5e_n2lvpzIxoT3ZASjE6ZQXrE35_ou-o"
			
		}
	}
	
	func isExist(with type: UserDefaultsType) -> Bool {
		switch type {
		case .oauth_permission_denied:
			return bool(forKey: UserDefaultsKeys.permission_denied.rawValue)
		case .oauth_access_token:
			return ((string(forKey: UserDefaultsKeys.access_token.rawValue) ?? String()).isEmpty) ? false : true
		case .oauth_user_login:
			return ((string(forKey: UserDefaultsKeys.login.rawValue) ?? String()).isEmpty) ? false : true
		case .firebase_apiKey:
			return ((string(forKey: UserDefaultsKeys.firebase_apiKey.rawValue) ?? String()).isEmpty) ? false : true
		}
	}
	
	func remove(with type: UserDefaultsType) {
		switch type {
		case .oauth_permission_denied:
			UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.permission_denied.rawValue)
		case .oauth_access_token:
			UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.access_token.rawValue)
		case .oauth_user_login:
			UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.login.rawValue)
		case .firebase_apiKey:
			UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.firebase_apiKey.rawValue)
		}
	}
}
