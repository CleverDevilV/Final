//
//  ProjectViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit Tests ???

class ProjectViewController: UIViewController {
	
	public var project: Project?
	
	private var numberOfTasksTableViewCell = 3
	private var numberOfCells = 4
	
	private var tableView: UITableView!
	private var netWorkService: NetworkManagerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .white
		title = project?.projectName
		
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		tableView.separatorStyle = .none
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.descriptionReuseId)
		tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: RepoTableViewCell.repoReuseId)
		tableView.register(CollaboratorsTableViewCell.self, forCellReuseIdentifier: CollaboratorsTableViewCell.collaboratorsReuseId)
		
		tableView.register(ViewWithCustomTableTableViewCell.self, forCellReuseIdentifier: ViewWithCustomTableTableViewCell.reusedId)
		
		tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: TasksTableViewCell.tasksReuseId)
		
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
		
		project?.repositoryName = URL(string: project?.repoUrl ?? "")?.lastPathComponent
		
		project?.repo = AppDelegate.shared.repositoryBase?.repositories.first{$0.name?.uppercased() == project?.repositoryName?.uppercased()}
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.tabBarController?.tabBar.isHidden = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		AppDelegate.shared.projectBase?.baseUpdated()
	}

}

extension ProjectViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return numberOfCells
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		if numberOfTasksTableViewCell != 3, indexPath.row == 3 {
			let cell = tableView.dequeueReusableCell(withIdentifier: ViewWithCustomTableTableViewCell.reusedId, for: indexPath) as! ViewWithCustomTableTableViewCell
			
			cell.project = project
			cell.arrayOfDataForPresent = project?.repo?.collaborators
			cell.typeOfData = "collaborators"
			
			return cell
		}
		if (numberOfCells == 5 && indexPath.row == 4 && numberOfTasksTableViewCell == 3) || (numberOfCells == 6 && indexPath.row == 5 && numberOfTasksTableViewCell == 4) {
			let cell = tableView.dequeueReusableCell(withIdentifier: ViewWithCustomTableTableViewCell.reusedId, for: indexPath) as! ViewWithCustomTableTableViewCell
			
			cell.project = project
			cell.arrayOfDataForPresent = project?.projectTasks
			cell.typeOfData = "tasks"
			cell.addTaskDelegate = self
			
			return cell
		}
		
		switch indexPath.row {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.descriptionReuseId, for: indexPath) as! DescriptionTableViewCell
			cell.descriptionTextView.text = project?.descriptionOfProject ?? ""
			cell.descriptionCellDelegate = self
			return cell
			
		case 1:
			let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.repoReuseId, for: indexPath) as! RepoTableViewCell
			cell.project = project
			cell.delegate = self
			return cell
			
		case 2:
			let cell = tableView.dequeueReusableCell(withIdentifier: CollaboratorsTableViewCell.collaboratorsReuseId, for: indexPath) as! CollaboratorsTableViewCell
			cell.delegate = self
			return cell
			
		case numberOfTasksTableViewCell:
			let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.tasksReuseId, for: indexPath) as! TasksTableViewCell
			cell.delegate = self
			cell.project = project
			return cell
			
		default:
			return cell
		}
	}
}

extension ProjectViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.cellForRow(at: indexPath)?.isSelected = false
	}
}

//MARK: - Cells Protocols

extension ProjectViewController: DescriptionTableViewCellDelegate {
	func projectDescriptionUpdate(_ description: String?) {
		project?.descriptionOfProject = description
	}
	
}

extension ProjectViewController: RepoTableCellDelegate {
	func setupRepo() {
		if project?.repositoryName == nil {
			let addRepoAlertController = UIAlertController(title: "Добавить репозиторий в проект?", message: "Введите URL репозитория", preferredStyle: .alert)

			addRepoAlertController.addTextField(configurationHandler: nil)

			let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
			let okAction = UIAlertAction(title: "OK", style: .default, handler: {
				_ in

				let textField = addRepoAlertController.textFields![0] as UITextField
				
				if let text = textField.text {
					let url = URL(string: text.replacingOccurrences(of: ".git", with: ""))!
					let name = url.pathComponents.last
					guard let repoName = name else {return}
					self.netWorkService = GitHubNetworkManager(with: AppDelegate.shared.session)
					self.netWorkService?.getData(endPoint: GitHubApi.oneRepo(repositoryName: repoName)) {
						repo, error in
						self.project?.repo = repo as? Repository
						self.project?.repoUrl = url.absoluteString
						self.project?.repositoryName = self.project?.repo?.name
						self.project?.languageOfProject = self.project?.repo?.languageOfProject
						DispatchQueue.main.async {
							self.tableView.reloadData()
						}
					}
					
				} else {
					return
				}
			})
			addRepoAlertController.addAction(cancelAction)
			addRepoAlertController.addAction(okAction)

			present(addRepoAlertController, animated: true, completion: nil)
		} else {
			let alertList = UIAlertController(title: "Выберите действие:", message: nil, preferredStyle: .actionSheet)
			
			let resetAction = UIAlertAction(title: "Изменить репозиторий", style: .default, handler: {_ in
				
				let addRepoAlertController = UIAlertController(title: "Изменить репозиторий в проекте?", message: "URL репозитория:", preferredStyle: .alert)
				
				addRepoAlertController.addTextField(configurationHandler: nil)
				if let urlOfRepository = self.project?.repoUrl {
					addRepoAlertController.textFields?[0].text = "\(urlOfRepository)"
				}
				
				let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
				let okAction = UIAlertAction(title: "OK", style: .default, handler: {
					_ in
					
					let textField = addRepoAlertController.textFields![0] 
					
					if let text = textField.text {
						let url = URL(string: text.replacingOccurrences(of: ".git", with: ""))!
						let name = url.pathComponents.last
						guard let repoName = name else {return}
						
						self.netWorkService = GitHubNetworkManager(with: AppDelegate.shared.session)
						self.netWorkService?.getData(endPoint: GitHubApi.oneRepo(repositoryName: repoName)) {
							repo, error in
							self.project?.repo = repo as? Repository
							self.project?.repoUrl = url.absoluteString
							DispatchQueue.main.async {
								self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
							}
						}
					} else {
						return
					}
				})
				addRepoAlertController.addAction(cancelAction)
				addRepoAlertController.addAction(okAction)
				self.present(addRepoAlertController, animated: true, completion: nil)
			})
			let viewRepositiryAtNet = UIAlertAction(title: "Открыть репозиторий в браузере", style: .default, handler: {_ in
				let view = SomeUrlWebViewController()
				view.url = URL(string: self.project?.repoUrl ?? "")
				self.navigationController?.pushViewController(view, animated: true)
				})
			
			let viewRepository = UIAlertAction(title: "Открыть станицу репозитория в приложении", style: .default, handler: {
				_ in
				let destinationView = RepoViewController()
				destinationView.repository = self.project?.repo
				self.navigationController?.pushViewController(destinationView, animated: true)
			})
			
			let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
			
			alertList.addAction(resetAction)
			alertList.addAction(viewRepositiryAtNet)
			alertList.addAction(cancelAction)
			alertList.addAction(viewRepository)
			
			present(alertList, animated: true, completion: nil)
		}
	}
}

extension ProjectViewController: CollaboratorsTableViewCellDelegate {
	func addCollaboratorsTable() {
		if numberOfTasksTableViewCell == 3 {
			numberOfTasksTableViewCell = 4
			numberOfCells += 1
		} else if numberOfTasksTableViewCell == 4 {
			numberOfTasksTableViewCell = 3
			numberOfCells -= 1
		}
		tableView.reloadData()
	}
}

extension ProjectViewController: TasksTableViewCellDelegate {
	func addTasksTable(){
		if (numberOfCells == 4 && numberOfTasksTableViewCell == 3) || (numberOfCells == 5 && numberOfTasksTableViewCell == 4) {
			numberOfCells += 1
		} else if (numberOfCells == 5 && numberOfTasksTableViewCell == 3) || (numberOfCells == 6 && numberOfTasksTableViewCell == 4) {
			numberOfCells -= 1
		}
		tableView.reloadData()
	}
}

extension ProjectViewController: ViewWithCustomTableTableViewCellDelegate {
	func addTask() {
		
		let addProjectAlertController = UIAlertController(title: "Добавить задачу", message: "", preferredStyle: .alert)
		
		addProjectAlertController.addTextField(configurationHandler: nil)
		
		let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
		let okAction = UIAlertAction(title: "OK", style: .default, handler: {
			_ in
			
			let textField = addProjectAlertController.textFields![0] as UITextField
			if let text = textField.text {
				self.project?.addTask(text)
				
				self.tableView.reloadData()
			} else {
				return
			}
		})
		addProjectAlertController.addAction(cancelAction)
		addProjectAlertController.addAction(okAction)
		
		present(addProjectAlertController, animated: true, completion: nil)
		
	}
}
