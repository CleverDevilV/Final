//
//  ReposTableVC.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class ReposTableVC: UIViewController {
	
	var netWork = NetworkService()
	
	var tableView: UITableView!
	var repos: [Repo]!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Репозитории"
		
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
		
		let stringURL = "https://api.github.com/user/repos"
		
		netWork.loadData(stringURL: stringURL) {
			result in
			self.repos = result
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}

    }
}

extension ReposTableVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return repos?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
		let repo = repos[indexPath.row]
		cell.textLabel?.text = "\(repo.name)"
		cell.detailTextLabel?.text = "Ownrer: \(repo.owner)   Language: \(repo.languageOfProject ?? "")"
		cell.accessoryType = .disclosureIndicator
		
		return cell
	}
	
}

extension ReposTableVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let destinationVC = RepoVC()
		
		destinationVC.repo = repos[indexPath.row]
		
		navigationController?.pushViewController(destinationVC, animated: true)
	}
}
