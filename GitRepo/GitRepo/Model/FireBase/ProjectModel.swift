//
//  ProjectModel.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

/// Class for Project from Firebase
public final class Project: Decodable {
	
	/// Name of project
	public var projectName: String
	/// Link to repository of project
	public var repoUrl: String?
	/// Name of projects retository
	public var repositoryName: String?
	/// Repository of project
	public var repo: Repository?
	
	public var descriptionOfProject: String?
	
	public var projectTasks: [String]?
	
	init(projectName: String, repoURL: String?, repositoryName: String? , repo: Repository?, descriptionOfProject: String?) {
		self.projectName = projectName
		self.repoUrl = repoURL
		self.repositoryName = repositoryName
		self.repo = repo
		self.descriptionOfProject = descriptionOfProject
	}
	
	/// Keys for decode Firebase Api Response
	private enum FirebaseApiResponseCodingKeys: String, CodingKey {
		
		case name
		case repoUrl
		case projectTasks
		case descriptionOfProject
	}
	
	/**
	Initializes a new repository with the provided fields.
	
	- Parameters:
	- decoder: Decoder for decode values.
	*/
	required public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: FirebaseApiResponseCodingKeys.self)
		
		self.projectName = try container.decode(String.self, forKey: .name)
		
		var url: String? = ""
		do {
			url = try container.decode(String?.self, forKey: .repoUrl)
		} catch {
			print(error)
		}
		self.repoUrl = url
		
		var tasks: [String]? = []
		
		do {
			tasks = try container.decode([String]?.self, forKey: .projectTasks)
		} catch {
			print(error)
		}
		
		self.projectTasks = tasks
		
		do {
			self.descriptionOfProject = try container.decode(String?.self, forKey: .descriptionOfProject)
		} catch {
			print(error)
			self.descriptionOfProject = nil
		}
		
		self.repo = nil
		
		self.repositoryName = nil
	}
	
	public func addTask(_ task: String) {
		self.projectTasks?.append(task)
	}
	
	public func removeTask(at index: Int) {
		self.projectTasks?.remove(at: index)
	}
}
