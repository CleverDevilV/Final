//
//  LogOutCommand.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit Tests

/**
Command For Logout User - reset UserDefaults.standard.remove(with: .oauth_access_token) and UserDefaults.standard.remove(with: .oauth_user_login).
Unit Tests - [LogOutCommandTests](x-source-tag://LogOutCommandTests)
*/
/// - Tag: LogOutCommand
class LogOutCommand {
	
	init() {}
	
	/// Reset UserDefaults.standard.remove(with: .oauth_access_token) and UserDefaults.standard.remove(with: .oauth_user_login)
	public func logOut() {
		UserDefaults.standard.remove(with: .oauth_access_token)
		UserDefaults.standard.remove(with: .oauth_user_login)
	}
}
