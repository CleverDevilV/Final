//
//  RepoVC.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {
	
	public var repository: Repository?
	private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .white
		title = repository?.name
		
		setupViews()
    }
	
	func setupViews() {
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		tableView.separatorStyle = .none
		
		tableView.dataSource = self
		
		tableView.register(OwnerAndViewButtonTableViewCell.self, forCellReuseIdentifier: OwnerAndViewButtonTableViewCell.ownerReuseId)
		
		view.addSubview(tableView)
	}
}

extension RepoViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: OwnerAndViewButtonTableViewCell.ownerReuseId, for: indexPath) as! OwnerAndViewButtonTableViewCell
		cell.delegate = self
		cell.repository = repository
		
		return cell
		
	}
	
	
}

extension RepoViewController: OwnerAndViewButtonTableViewCellDelegate {
	func tapRepoButton() {
		let view = RepositoryWebViewController()
		view.url = URL(string: self.repository?.repoLink ?? "")
		self.navigationController?.pushViewController(view, animated: true)
	}
}
