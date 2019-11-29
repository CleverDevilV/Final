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
//	var projects: [Project] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		
		updateData()
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProject))
		navigationItem.rightBarButtonItem = addButton
		title = "Проекты"
		
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
		
		// ?
		projectsSelector = UISegmentedControl(items: ["Все", "Мои"])
		projectsSelector.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 50, height: 20))
		navigationItem.titleView?.addSubview(projectsSelector)
	}

	@objc
	func addProject() {
		
	}
	
	func updateData() {
		
		if !UserDefaults.standard.isExist(with: .oauth_access_token) {
			present(RequestViewController(), animated: false, completion: nil)
		}
		
		//		guard !token.isEmpty else {
		//			requestToken()
		//			return
		//		}
	}

}

extension ProjectsTableVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10//projects.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
//		let project = projects[indexPath.row]
		cell.textLabel?.text = "\(indexPath.row)"//project.projectName
//		cell.detailTextLabel?.text = "Language: \(project.repo.languageOfProject)"
		cell.accessoryType = .disclosureIndicator
		
		return cell
	}
	
}

extension ProjectsTableVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let destinationVC = ProjectVC()
//		destinationVC.project = projects[indexPath.row]
		
		navigationController?.pushViewController(destinationVC, animated: true)
	}
}

