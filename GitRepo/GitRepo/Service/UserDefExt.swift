//
//  UserDef.swift
//  GitRepo
//
//  Created by Дарья Витер on 29/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

 // Unit tests
 /// Unit Tests - [UserDefaultsTests](x-source-tag://UserDefaultsTests)
enum UserDefaultsKeys : String {
	case permission_denied
	case access_token
	case login
	case firebase_apiKey // = "AIzaSyC5e_n2lvpzIxoT3ZASjE6ZQXrE35_ou-o"
}

enum UserDefaultsType : String {
	
	case oauth_access_token
	case oauth_user_login
	case firebase_apiKey
}


extension UserDefaults {
	
	/// Function For Set Value For Specified Key.
	func update(with type: UserDefaultsType, data: Any?) {
		switch type {
			
		case .oauth_access_token:
			if let oauth = data as? OAuthResponse {
				set(oauth.access_token, forKey: UserDefaultsKeys.access_token.rawValue)
				print("token updated, token = ", oauth.access_token)
			} else {
				guard let login = data as? String else { return }
				set(login, forKey: UserDefaultsKeys.access_token.rawValue)
			}
			
		case .oauth_user_login:
			guard let login = data as? String else { return }
			set(login, forKey: UserDefaultsKeys.login.rawValue)
			print("login updated, login = ", login)
			
		case .firebase_apiKey:
			guard let login = data as? String else { return }
			set(login, forKey: UserDefaultsKeys.firebase_apiKey.rawValue)
		}
	}
	
	/// Function For Get Value For Specified Key.
	func get(with type: UserDefaultsType) -> String {
		switch type {
			
		case .oauth_access_token:
			return (string(forKey: UserDefaultsKeys.access_token.rawValue) ?? String())
		case .oauth_user_login:
			return (string(forKey: UserDefaultsKeys.login.rawValue) ?? String())
		case .firebase_apiKey:
			return (string(forKey: UserDefaultsKeys.firebase_apiKey.rawValue) ?? String()) //"AIzaSyC5e_n2lvpzIxoT3ZASjE6ZQXrE35_ou-o"
			
		}
	}
	
	/// Function For Get Boolean Value if Sets Specified Key.
	func isExist(with type: UserDefaultsType) -> Bool {
		switch type {
			
		case .oauth_access_token:
			return ((string(forKey: UserDefaultsKeys.access_token.rawValue) ?? String()).isEmpty) ? false : true
		case .oauth_user_login:
			return ((string(forKey: UserDefaultsKeys.login.rawValue) ?? String()).isEmpty) ? false : true
		case .firebase_apiKey:
			return ((string(forKey: UserDefaultsKeys.firebase_apiKey.rawValue) ?? String()).isEmpty) ? false : true
		}
	}
	
	/// Function For Remove Value For Specified Key.
	func remove(with type: UserDefaultsType) {
		switch type {
			
		case .oauth_access_token:
			UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.access_token.rawValue)
		case .oauth_user_login:
			UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.login.rawValue)
		case .firebase_apiKey:
			UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.firebase_apiKey.rawValue)
		}
	}
}
