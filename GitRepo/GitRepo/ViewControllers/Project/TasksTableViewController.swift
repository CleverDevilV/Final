//
//  TasksTableViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class TasksTableViewController: UIViewController {
	
	public var project: Project? {
		didSet {
			self.setupViews()
		}
	}
	
	private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = project?.projectName
		
		setupViews()
    }

	func setupViews() {
		tableView = UITableView(frame: view.frame)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.dataSource = self
		
		view.addSubview(tableView)
		
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
		let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditing))
		navigationItem.rightBarButtonItems = [addButton,editButton]
	}
	
	@objc
	func addTask() {
		project?.addTask("task")
		tableView.reloadData()
	}
	
	@objc private func toggleEditing() {
		tableView.setEditing(!tableView.isEditing, animated: true)
		navigationItem.rightBarButtonItems?[1].title = tableView.isEditing ? "Done" : "Edit"
	}
}
extension TasksTableViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return project?.projectTasks?.count ?? 0//10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		cell.textLabel?.text = "\(indexPath.row)"
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			project?.removeTask(at: indexPath.row)
			self.tableView.reloadData()
		}
	}
}

extension TasksTableViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return UITableViewCell.EditingStyle.delete
	}
}
