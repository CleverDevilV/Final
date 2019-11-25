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

	override func viewDidLoad() {
		super.viewDidLoad()
		
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

}

extension ProjectsTableVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		cell.textLabel?.text = "\(indexPath.row)"
		cell.accessoryType = .disclosureIndicator
		
		return cell
	}
	
}

extension ProjectsTableVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let destinationVC = ProjectVC()
		destinationVC.title = "Проект"
		
		navigationController?.pushViewController(destinationVC, animated: true)
	}
}

