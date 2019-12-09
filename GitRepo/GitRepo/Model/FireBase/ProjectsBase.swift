//
//  ProjectsBase.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit tests


/**
Base for projects
```
private (set) var projects: [Project]
private var userName: String from UserDefaults.standard
```
*/
/// - Tag: ProjectsBase
final class ProjectsBase: Decodable {
	
	private (set) var projects: [Project] = []
	private var userName: String = UserDefaults.standard.get(with: .oauth_user_login)
	
	init(with data: Data?) {
		
		if let data = data {
			decodeRepositories(data)
		}
	}
	
	init(with projects: [Project]?) {
		if let projects: [Project] = projects {
			self.projects = projects
		}
	}
	
	private func decodeRepositories(_ data: Data) {
		do {
			let allProjects = try JSONDecoder().decode([String : [Project]].self, from: data)
			let usersProjects = allProjects.filter{$0.key.uppercased() == userName.uppercased()}.first?.value
			
			guard let usersprojects = usersProjects else { return }
			self.projects = usersprojects
			print("Ok decode")
			
		} catch {
			print(error.localizedDescription)
		}
	}
	
	/// Add project to ProjectBase and load to Back
	public func addProject(_ project: Project) {
		self.projects.append(project)
		self.loadToBack()
	}
	
	/// Remove project from ProjectBase and load to Back
	public func removeProject(atIndex index: Int) {
		self.projects.remove(at: index)
		self.loadToBack()
	}
	
	/// Load Base to Back
	public func baseUpdated() {
		self.loadToBack()
	}
	
	private func loadToBack() {
//		guard NSClassFromString("ProjectBaseTests") == nil else { return }
		
		guard NSClassFromString("XCTestCase") == nil else { return }
//		guard AppDelegate.shared != nil else { return }
		
		let network = FirebaseNetworkManager(with: AppDelegate.shared.session)
		var uploadData: [String : [ProjectForUploadToBack]] = [userName : []]
		
		for project in projects {
			let projectToUpload = ProjectForUploadToBack(name: project.projectName, repoUrl: project.repoUrl, repositoryName: project.repositoryName, projectTasks: project.projectTasks, descriptionOfProject: project.descriptionOfProject, languageOfProject: project.repo?.languageOfProject)
			uploadData[userName]?.append(projectToUpload)
		}
		network.getData(endPoint: FirebaseApi.uploadProjects(data: uploadData)) {
			result, error in
//			print(result)
		}
	}
}
