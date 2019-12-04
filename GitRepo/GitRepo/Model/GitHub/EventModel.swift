//
//  EventModel.swift
//  GitRepo
//
//  Created by Дарья Витер on 04/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

struct Event: Codable {
	let id: String
	let type: String
	var actor: User
	let commits: [Commit]
	let created_at: String
	
}

struct Commit: Codable {
	let sha: String
	let message: String?
	let url: String
}
