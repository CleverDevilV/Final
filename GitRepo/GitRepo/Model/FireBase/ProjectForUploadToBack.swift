//
//  ProjectForUploadToBack.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// No Unit Tests

public struct ProjectForUploadToBack: Codable {
	var name: String
	var repoUrl: String?
	var repositoryName: String?
	var projectTasks: [String]?
	var descriptionOfProject: String?
}
