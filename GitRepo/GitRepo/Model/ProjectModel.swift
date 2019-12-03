//
//  ProjectModel.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

/// Class for Project from Firebase
final class Project: Decodable {
	
	/// Name of project
	public var projectName: String
	/// Link to repository of project
	public var repoUrl: URL?
	/// Repository of project
	public var repo: Repository?
	
	init(projectName: String, repoURL: URL?, repo: Repository?) {
		self.projectName = projectName
		self.repoUrl = repoURL
		self.repo = repo
	}
	
	/// Keys for decode Firebase Api Response
	private enum FirebaseApiResponseCodingKeys: String, CodingKey {
		
		case name
		case repoUrl
	}
	
	/**
	Initializes a new repository with the provided fields.
	
	- Parameters:
	- decoder: Decoder for decode values.
	*/
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: FirebaseApiResponseCodingKeys.self)
		
		
		
		self.projectName = try container.decode(String.self, forKey: .name)
		self.repoUrl = try container.decode(URL?.self, forKey: .repoUrl)
		
		self.repo = nil
	}

	
	
}
