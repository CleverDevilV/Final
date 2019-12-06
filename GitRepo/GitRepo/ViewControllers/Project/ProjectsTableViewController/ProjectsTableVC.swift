//
//  ViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class ProjectsTableVC: UIViewController {
	
	private var tableView: UITableView!
	private var projectsSelector: UISegmentedControl!
	
	private var projectsBase: ProjectsBase? = AppDelegate.shared.projectBase
//	private var projects: [Project] = [] {
//		didSet {
//			DispatchQueue.main.async {
//				self.tableView.reloadData()
//			}
//		}
//	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
		
		// ?
		projectsSelector = UISegmentedControl(items: ["Все", "Мои"])
		projectsSelector.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 50, height: 20))
		navigationItem.titleView?.addSubview(projectsSelector)
		
//		downloadProjects()
	}
	
//	private func downloadProjects() {
//		let network = FirebaseNetworkManager()
//		network.getFirebaseData(endPoint: FirebaseApi.getProjects) {
//			result, error in
//			if error != nil {
//				print(error!)
//			}
//
//			self.projectsBase = result as? ProjectsBase
////
////			guard let result = self.projectsBase?.projects else { return }
////			self.projects = result
//			DispatchQueue.main.async {
//				self.tableView.reloadData()
//			}
//		}
//	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
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
				self.projectsBase?.addProject(Project(projectName: text, repoURL: nil, repositoryName: nil, repo: nil, descriptionOfProject: nil))
				self.projectsBase?.baseUpdated()
				
				self.tableView.reloadData()
//				self.projects = self.projectsBase?.projects ?? []
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

extension ProjectsTableVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return projectsBase?.projects.count ?? 0
//		return projects.count
//		return 1
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

extension ProjectsTableVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.cellForRow(at: indexPath)?.isSelected = false
		let destinationVC = ProjectViewController()
		
//		let destinationVC = ProjectVC()
		guard let project = projectsBase?.projects[indexPath.row] else { return }
		
		destinationVC.project = project
		
		navigationController?.pushViewController(destinationVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return UITableViewCell.EditingStyle.delete
	}
}

