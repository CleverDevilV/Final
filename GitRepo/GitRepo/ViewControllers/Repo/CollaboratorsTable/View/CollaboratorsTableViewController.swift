//
//  CollaboratorsTableViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit Tests

 /// Unit Tests - [CollaboratorsTableViewControllerTests](x-source-tag://CollaboratorsTableViewControllerTests)
class CollaboratorsTableViewController: UIViewController {
	
	public var presenter: CollaboratorsTablePresenterProtocol!
	
	private var repository: Repository!
	
	private var collaboratorsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		presenter.setRepository()
		
		setupViews()
		
		view.addSubview(collaboratorsTable)
    }
	
	func setupViews() {
		
		view.backgroundColor = .white
		
		collaboratorsTable = UITableView(frame: view.frame, style: .plain)
		collaboratorsTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		collaboratorsTable.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		
		collaboratorsTable.dataSource = self
		collaboratorsTable.delegate = self
		
	}
}

extension CollaboratorsTableViewController: CollaboratorsTableViewProtocol {
	func setupRepository(_ repository: Repository) {
		self.repository = repository
	}
}

extension CollaboratorsTableViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return repository.collaborators?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		let collaborator = repository.collaborators?[indexPath.row]
		
		if let collaborator = collaborator {
			cell.textLabel?.text = collaborator.login
		}
		
		cell.backgroundColor = .clear
		
		return cell
	}
}

extension CollaboratorsTableViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.cellForRow(at: indexPath)?.isSelected = false
	}
}
