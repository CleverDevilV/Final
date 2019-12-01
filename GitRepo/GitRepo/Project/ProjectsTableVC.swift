//
//  ViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class ProjectsTableVC: UIViewController {
	
	var tableView: UITableView!
	var projectsSelector: UISegmentedControl!
	var projects: [Project] = [Project(projectName: "MyProject", repo: Repo(name: "myRepo", repoLink: nil, collaborators: [], changes: [:], owner: "i"))]

	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		updateData()
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProject))
		let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditing))
		navigationItem.rightBarButtonItems = [addButton,editButton]
		
		title = "Проекты"
		
		
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583) //#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
		
		// ?
		projectsSelector = UISegmentedControl(items: ["Все", "Мои"])
		projectsSelector.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 50, height: 20))
		navigationItem.titleView?.addSubview(projectsSelector)
	}
	
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
				self.projects.append(Project(projectName: text, repo: nil))
			} else {
				return
			}
			
			self.tableView.reloadData()
		})
		addProjectAlertController.addAction(cancelAction)
		addProjectAlertController.addAction(okAction)
		
		present(addProjectAlertController, animated: true, completion: nil)
	}
	
	@objc private func toggleEditing() {
		tableView.setEditing(!tableView.isEditing, animated: true)
		navigationItem.rightBarButtonItems?[1].title = tableView.isEditing ? "Done" : "Edit"
	}
	
	func updateData() {

		if !UserDefaults.standard.isExist(with: .oauth_access_token) {
			present(RequestViewController(), animated: false, completion: nil)
		}
	}

}

extension ProjectsTableVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return projects.count
//		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		let project = projects[indexPath.row]
//		cell.textLabel?.text = "\(indexPath.row)"
		cell.textLabel?.text = project.projectName
//		cell.detailTextLabel?.text = "Language: \(project.repo.languageOfProject)"
		cell.accessoryType = .disclosureIndicator
		cell.backgroundColor = .clear
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			
			projects.remove(at: indexPath.row)
//			NoteService.shared.notes.remove(at: indexPath.row)
//			uploadPosts(NoteService.shared.notes) {
//				result in
//				print(result)
//				print("--------------------")
//				print("Notes uploaded")
//				DispatchQueue.main.async {
//					self.tableView.reloadData()
//				}
//			}
//			navigationController?.viewControllers[0].title = "Заметки (\(notesArray.count))"
			tableView.reloadData()
		}
	}
	
}

extension ProjectsTableVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.cellForRow(at: indexPath)?.isSelected = false
		let destinationVC = ProjectViewController()
		
//		let destinationVC = ProjectVC()
		destinationVC.project = projects[indexPath.row]
		
		navigationController?.pushViewController(destinationVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return UITableViewCell.EditingStyle.delete
	}
}

