//
//  ViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit Tests

protocol ProjectsTableViewControllerProtocol {
	func setProjectsBase()
}

/// Show Projects ViewControiller
class ProjectsTableViewController: UIViewController {
	
	public var presenter: ProjectsTablePresenterProtocol!
	
	// UI
	private var tableView: UITableView!
	private var projectsSelector: UISegmentedControl!
	
	private var projectsBase: ProjectsBase?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		presenter.setProjectsBase()
		
		view.backgroundColor = .white
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProject))
		let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditing))
		navigationItem.rightBarButtonItems = [addButton,editButton]
		
		title = "Проекты"
		
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583) //#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.reusedId)
		
		tableView.separatorStyle = .none
		
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.tableView.reloadData()
		
		self.tabBarController?.tabBar.isHidden = false
	}
	
	@objc
	func addProject() {
		let addProjectAlertController = UIAlertController(title: "Добавить проект", message: "Введите наименование проекта", preferredStyle: .alert)
		
		addProjectAlertController.addTextField(configurationHandler: nil)
		
		let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
		let okAction = UIAlertAction(title: "OK", style: .default, handler: {
			_ in
			
			let textField = addProjectAlertController.textFields![0] as UITextField
			if let text = textField.text {
				self.projectsBase?.addProject(Project(projectName: text, repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: nil, languageOfProject: nil))
				self.projectsBase?.baseUpdated()
				
				self.tableView.reloadData()
			} else {
				return
			}
		})
		
		addProjectAlertController.addAction(cancelAction)
		addProjectAlertController.addAction(okAction)
		
		present(addProjectAlertController, animated: true, completion: nil)
	}
	
	@objc private func toggleEditing() {
		tableView.setEditing(!tableView.isEditing, animated: true)
		navigationItem.rightBarButtonItems?[1].title = tableView.isEditing ? "Done" : "Edit"
	}
}

extension ProjectsTableViewController: ProjectsTableViewProtocol {
	func set(projectsBase: ProjectsBase) {
		self.projectsBase = projectsBase
	}
}

extension ProjectsTableViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return projectsBase?.projects.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.reusedId, for: indexPath) as! ProjectTableViewCell
		
		guard let project = projectsBase?.projects[indexPath.row]  else { return cell }
		
		cell.project = project
		
		cell.accessoryType = .disclosureIndicator
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			
			projectsBase?.removeProject(atIndex: indexPath.row)
			self.tableView.reloadData()
		}
	}
}

extension ProjectsTableViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.cellForRow(at: indexPath)?.isSelected = false
//		let destinationVC = ProjectViewController()
//
//		guard let project = projectsBase?.projects[indexPath.row] else { return }
//
//		destinationVC.project = project
		
		let project = projectsBase?.projects[indexPath.row]
		
		guard let projectView = Builder.createProjectViewController(with: project) else { return }
		
		navigationController?.pushViewController(projectView, animated: true)
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return UITableViewCell.EditingStyle.delete
	}
}

