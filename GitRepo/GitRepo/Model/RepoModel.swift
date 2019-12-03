
//
//  RepoModel.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

/// Class for Repository from GitHub
final class Repository: Decodable {
	
	/// Name of repository
	public var name: String?
	/// Link to repository
	public var repoLink: String?
	/// Link for list of collaborators of repository
	var collaborators: String?
	
	/// Link for events of repository
	var changes: String?
	/// Language of repository
	var languageOfProject: String?
	/// Field for **Owner** of repository
	var owner: Owner?
	/// Id of repository
	var id: Int?
	
	/**
	Keys for decode GitHub Api Response.
	
	````
	case name
	case repoLink
	case collaborators
	case changes
	case languageOfProject
	case owner
	case id
	````
	*/
	private enum GitHubApiResponseCodingKeys: String, CodingKey {
		
		case name
		case repoLink = "html_url"
		case collaborators = "collaborators_url"
		
		case changes = "events_url"
		case languageOfProject = "language"
		case owner
		case id
	}
	
	/**
	Initializes a new repository with the provided fields.
	
	- Parameters:
		- decoder: Decoder for decode values.
	*/
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: GitHubApiResponseCodingKeys.self)
		
		
		
		self.name = try container.decode(String?.self, forKey: .name)
		self.repoLink = try container.decode(String?.self, forKey: .repoLink)
		self.collaborators = try container.decode(String?.self, forKey: .collaborators)
		
		self.changes = try container.decode(String?.self, forKey: .changes)
		self.languageOfProject = try container.decode(String?.self, forKey: .languageOfProject)
		self.owner = try container.decode(Owner?.self, forKey: .owner)
		self.id = try container.decode(Int?.self, forKey: .id)
	}
}
