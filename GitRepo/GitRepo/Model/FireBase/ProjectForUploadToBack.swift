//
//  ProjectForUploadToBack.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

public struct ProjectForUploadToBack: Codable {
	var name: String
	var repoUrl: String?
	var projectTasks: [String]?
}
