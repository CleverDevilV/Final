//
//  ReposTableVC.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class RepositoriesTableViewController: UIViewController {
	
//	private var netWork = NetworkService()
//	private let network = GitHubNetworkManager()
	
	private var tableView: UITableView!
	private var repositoryBase: RepositoriesBase? = AppDelegate.shared.repositoryBase
	private var repositories: [Repository]! {
		didSet {
			DispatchQueue.main.async {
				if self.segmentControl.selectedSegmentIndex == 0 {
					self.repositories = self.repositoryBase?.repositories.filter({$0.owner?.login == self.repositoryBase?.userName})
				}
				self.tableView.reloadData()
			}
		}
	}
	private var segmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .white
		self.tabBarController?.tabBar.isHidden = false
		
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
//		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.register(RepositoriesTableViewCell.self, forCellReuseIdentifier: RepositoriesTableViewCell.repositoriesCellReuseId)
		
		tableView.separatorStyle = .none
		
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
		
		
		
//		downloadData()
		
		setupSegmentControll()
    }
	
//	func downloadData() {
//		let network = GitHubNetworkManager()
//		network.getGitHubData(endPoint: GitHubApi.repos) {
//			result, error in
//			if error != nil {
//				print(error!)
//			}
//			guard let result = result as? RepositoriesBase else { return }
//			
//			self.repositoryBase = result
//			self.repositories = result.repositories
//			DispatchQueue.main.async {
//				self.tableView.reloadData()
//			}
//		}
//	}
	
	func setupSegmentControll() {
		let titles = ["Мои", "Все"]
		segmentControl = UISegmentedControl(items: titles)
		segmentControl.tintColor = UIColor(red: 0, green: 0.4784313725, blue: 1, alpha: 1) // #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
		segmentControl.selectedSegmentIndex = 0
		for index in 0...titles.count-1 {
			segmentControl.setWidth(120, forSegmentAt: index)
		}
		segmentControl.sizeToFit()
		segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
		segmentControl.selectedSegmentIndex = 0
		segmentControl.sendActions(for: .valueChanged)
		navigationItem.titleView = segmentControl
	}
	
	@objc
	func segmentChanged() {
		if segmentControl.selectedSegmentIndex == 0, !(repositories?.isEmpty ?? true) {
			repositories = repositoryBase?.repositories.filter({$0.owner?.login == repositoryBase?.userName})
		} else {
			repositories = repositoryBase?.repositories
		}
	}
	
}

extension RepositoriesTableViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return repositories?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: RepositoriesTableViewCell.repositoriesCellReuseId, for: indexPath) as! RepositoriesTableViewCell
		cell.repository = repositories[indexPath.row]
		
		cell.accessoryType = .disclosureIndicator
		cell.backgroundColor = .clear
		return cell
	}
	
}

extension RepositoriesTableViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let destinationVC = RepoViewController()
		
		destinationVC.repository = repositories[indexPath.row]
		
		navigationController?.pushViewController(destinationVC, animated: true)
	}
}
