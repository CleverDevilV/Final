//
//  ReposTableVC.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit Tests

 /// Unit Tests - [RepositoriesTableViewControllerTests](x-source-tag://RepositoriesTableViewControllerTests)
class RepositoriesTableViewController: UIViewController {
	
	public var presenter: RepositoriesPresenterProtocol!
	
	private var tableView: UITableView!
	
	private var repositoryBase: RepositoriesBase?
	
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
		
		presenter.setRepositoriBase()
		
		view.backgroundColor = .white
		self.tabBarController?.tabBar.isHidden = false
		
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		tableView.register(RepositoriesTableViewCell.self, forCellReuseIdentifier: RepositoriesTableViewCell.repositoriesCellReuseId)
		
		tableView.separatorStyle = .none
		
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
		
		setupSegmentControll()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.tabBarController?.tabBar.isHidden = false
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
		if segmentControl.selectedSegmentIndex == 0, !(repositories?.isEmpty ?? true) {
			repositories = repositoryBase?.repositories.filter({$0.owner?.login == repositoryBase?.userName})
		} else {
			repositories = repositoryBase?.repositories
		}
	}
	
}

extension RepositoriesTableViewController: RepositoriesTableViewProtocol {
	func setupRepositoriBase(_ repositoryBase: RepositoriesBase) {
		self.repositoryBase = repositoryBase
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
		tableView.cellForRow(at: indexPath)?.isSelected = false
		
//		let destinationVC = RepoViewController()
		
//		destinationVC.repository = repositories[indexPath.row]
		
		let repository = repositories[indexPath.row]
		
		guard let repositoryView = Builder.createRepositoryViewController(with: repository) else { return }
		
		navigationController?.pushViewController(repositoryView, animated: true)
	}
}
