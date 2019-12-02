//
//  ReposTableVC.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class ReposTableViewController: UIViewController {
	
//	private var netWork = NetworkService()
	private let network = GitHubNetworkManager()
	
	private var tableView: UITableView!
	private var repos: [Repository]! {
		didSet {
				DispatchQueue.main.async {
					if self.segmentControl.selectedSegmentIndex == 0{
						self.repos = self.repos.filter({$0.owner?.login == "CleverDevilV"})
//						self.repos.sort{$0.name < $1.name}
						self.tableView.reloadData()
					} else {
//						self.repos.sort{$0.name < $1.name}
						self.tableView.reloadData()
					}
//
					
			}
		}
	}
	private var segmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .white
		
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
		
		
		
		downloadData()
		
		setupSegmentControll()
    }
	
	func downloadData() {
		network.getUserLogin(endPoint: GitHubApi.repos) {
			result, error in
			if error != nil {
				print(error!)
			}
			guard let result = result as? [Repository] else { return }

			self.repos = result
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
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
		downloadData()
//		if segmentControl.selectedSegmentIndex == 0, !(repos?.isEmpty ?? true) {
//			repos = repos.filter({$0.owner == "CleverDevilV"})
//			tableView.reloadData()
//		} else {
//			repos = repos
//		}
	}
	
}

extension ReposTableViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return repos?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
		let repo = repos[indexPath.row]
		cell.textLabel?.text = "\(repo.name ?? "")"
		cell.detailTextLabel?.text = "Ownrer: \(repo.owner?.login ?? "")   Language: \(repo.languageOfProject ?? "")"
		cell.accessoryType = .disclosureIndicator
		
		cell.backgroundColor = .clear
		return cell
	}
	
}

extension ReposTableViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let destinationVC = RepoViewController()
		
		destinationVC.repo = repos[indexPath.row]
		
		navigationController?.pushViewController(destinationVC, animated: true)
	}
}
