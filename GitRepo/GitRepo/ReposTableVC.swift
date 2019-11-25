//
//  ReposTableVC.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class ReposTableVC: UIViewController {
	
	var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Репозитории"
		
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
		
    }
}

extension ReposTableVC: UITableViewDataSource {
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

extension ReposTableVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let destinationVC = RepoVC()
		destinationVC.title = "Репозиторий"
		
		navigationController?.pushViewController(destinationVC, animated: true)
	}
}
