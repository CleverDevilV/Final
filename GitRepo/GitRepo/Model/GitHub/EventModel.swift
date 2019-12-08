//
//  EventModel.swift
//  GitRepo
//
//  Created by Дарья Витер on 04/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// No Unit Tests

struct Event: Codable {
	let id: String
	let type: String
	var actor: User
	let payload: Commits
	let created_at: String
}


