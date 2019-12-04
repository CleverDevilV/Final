//
//  ProjectViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

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
		
		tableView.register(AddViewTableViewCell.self, forCellReuseIdentifier: AddViewTableViewCell.reusedId)
		
		tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: TasksTableViewCell.tasksReuseId)
		
		tableView.dataSource = self
		
		view.addSubview(tableView)
		
		let projectRepoName = URL(string: project?.repoUrl ?? "")?.lastPathComponent
		
		project?.repo = AppDelegate.shared.repositoryBase?.repositories.first{$0.name?.uppercased() == projectRepoName?.uppercased()}
		
		self.tabBarController?.tabBar.isHidden = true
    }

}

extension ProjectViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return numberOfCells
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//		cell.backgroundColor = .clear
		
		if numberOfTasksTableViewCell != 3, indexPath.row == 3 {
			let cell = tableView.dequeueReusableCell(withIdentifier: AddViewTableViewCell.reusedId, for: indexPath) as! AddViewTableViewCell
			
			cell.project = project
			cell.arrayOfDataForPresent = project?.repo?.collaborators ?? []
			return cell
		}
		if (numberOfCells == 5 && indexPath.row == 4 && numberOfTasksTableViewCell == 3) || (numberOfCells == 6 && indexPath.row == 5 && numberOfTasksTableViewCell == 4) {
			let cell = tableView.dequeueReusableCell(withIdentifier: AddViewTableViewCell.reusedId, for: indexPath) as! AddViewTableViewCell
			
			cell.project = project
			cell.arrayOfDataForPresent = project?.projectTasks
			return cell
		}
		
		switch indexPath.row {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.descriptionReuseId, for: indexPath) as! DescriptionTableViewCell
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
//			fallthrough
		case numberOfTasksTableViewCell:
			let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.tasksReuseId, for: indexPath) as! TasksTableViewCell
			cell.delegate = self
			cell.project = project
			return cell
//			fallthrough
		default:
			return cell
		}
	}
}

//extension ProjectViewController: UITableViewDelegate {
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//	}
//}


extension ProjectViewController: RepoTableCellDelegate {
	func setupRepo() {
		if project?.repoUrl == nil {
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
					
					self.netWorkService?.getData(endPoint: GitHubApi.oneRepo(url: repoName)) {
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

				//				self.tableView.reloadData()
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
						
						self.netWorkService = GitHubNetworkManager()
						self.netWorkService?.getData(endPoint: GitHubApi.oneRepo(url: repoName)) {
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
		
//		collaboratorsTableViewHeight.isActive = false
//
//		if !isExtendedCollaborators {
//			collaboratorsButton.titleLabel?.transform = CGAffineTransform(rotationAngle: .pi)
//			heightOfCollaboratorsTable = 100
//		} else {
//			heightOfCollaboratorsTable = 0
//			collaboratorsButton.titleLabel?.transform = CGAffineTransform(rotationAngle: 0)
//		}
//
//		isExtendedCollaborators = !isExtendedCollaborators
//
//		collaboratorsTableViewHeight = collaboratorsTableView.heightAnchor.constraint(equalToConstant: heightOfCollaboratorsTable)
//		collaboratorsTableViewHeight.isActive = true
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
		
//		let destination = TasksTableViewController()
//		destination.project = self.project
//		self.navigationController?.pushViewController(destination, animated: true)
		
		//		collaboratorsTableViewHeight.isActive = false
		//
		//		if !isExtendedCollaborators {
		//			collaboratorsButton.titleLabel?.transform = CGAffineTransform(rotationAngle: .pi)
		//			heightOfCollaboratorsTable = 100
		//		} else {
		//			heightOfCollaboratorsTable = 0
		//			collaboratorsButton.titleLabel?.transform = CGAffineTransform(rotationAngle: 0)
		//		}
		//
		//		isExtendedCollaborators = !isExtendedCollaborators
		//
		//		collaboratorsTableViewHeight = collaboratorsTableView.heightAnchor.constraint(equalToConstant: heightOfCollaboratorsTable)
		//		collaboratorsTableViewHeight.isActive = true
	}
	
	
}

