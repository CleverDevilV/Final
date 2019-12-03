//
//  LogOutCommand.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

class LogOutCommand {
	
	init() {}
	
	public func logOut() {
		UserDefaults.standard.remove(with: .oauth_access_token)
		UserDefaults.standard.remove(with: .oauth_user_login)
		
		print("userdef token: ", UserDefaults.standard.get(with: .oauth_access_token))
	}
}
