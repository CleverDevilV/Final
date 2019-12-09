//
//  RepoVC.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// No Unit Tests

class RepoViewController: UIViewController {
	
	public var repository: Repository?
	private var segmentControllerValue: Int?
	
	private var tableViewWithLabelsAndButtons = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .white
		title = repository?.name
		
		setupViews()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.tabBarController?.tabBar.isHidden = true
	}
	
	func setupViews() {
		
		tableViewWithLabelsAndButtons = UITableView(frame: view.frame, style: .plain)
		tableViewWithLabelsAndButtons.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		tableViewWithLabelsAndButtons.separatorStyle = .none
		
		tableViewWithLabelsAndButtons.dataSource = self
		tableViewWithLabelsAndButtons.delegate = self
		
		tableViewWithLabelsAndButtons.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		
		tableViewWithLabelsAndButtons.register(OwnerAndViewButtonTableViewCell.self, forCellReuseIdentifier: OwnerAndViewButtonTableViewCell.ownerReuseId)
		tableViewWithLabelsAndButtons.register(RepositoryCollaboratorsTableViewCell.self, forCellReuseIdentifier: RepositoryCollaboratorsTableViewCell.collaboratorsReuseId)
		tableViewWithLabelsAndButtons.register(SegmentCommitsBranchesTableViewCell.self, forCellReuseIdentifier: SegmentCommitsBranchesTableViewCell.separatorCommitsBranchesReuseId)
		
		tableViewWithLabelsAndButtons.register(ViewWithCustomTableTableViewCell.self, forCellReuseIdentifier: ViewWithCustomTableTableViewCell.reusedId)
		
		view.addSubview(tableViewWithLabelsAndButtons)
	}
}

extension RepoViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView == tableViewWithLabelsAndButtons {
			return 3
		}
		else {
			if segmentControllerValue == nil || segmentControllerValue == 0 {
				return repository?.commits?.count ?? 0
			} else {
				return repository?.branches?.count ?? 0
			}
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return createCellForTableView(tableView, indexPath: indexPath)
	}
	
	func createCellForTableView(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell{
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		switch indexPath.row {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: OwnerAndViewButtonTableViewCell.ownerReuseId, for: indexPath) as! OwnerAndViewButtonTableViewCell
			cell.repository = repository
			cell.delegate = self
			return cell
			
		case 1:
			let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCollaboratorsTableViewCell.collaboratorsReuseId, for: indexPath) as! RepositoryCollaboratorsTableViewCell
			cell.delegate = self
			cell.repository = repository
			return cell
			
		case 2:
			let cell = tableView.dequeueReusableCell(withIdentifier: SegmentCommitsBranchesTableViewCell.separatorCommitsBranchesReuseId, for: indexPath) as! SegmentCommitsBranchesTableViewCell
			cell.repository = repository
			cell.delegate = self
			return cell
		default:
			return cell
		}
	}
}

extension RepoViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
			tableView.cellForRow(at: indexPath)?.isSelected = false
	}
}

extension RepoViewController: OwnerAndViewButtonTableViewCellDelegate {
	func tapRepoButton() {
//		let view = SomeUrlWebViewController()
		let view = Builder.createSomeWebView(with: self.repository?.repoLink ?? "")
//		view.url = URL(string: self.repository?.repoLink ?? "")
		self.navigationController?.pushViewController(view, animated: true)
	}
}

extension RepoViewController: RepositoryCollaboratorsTableViewCellDelegate {
	func showCollaboratorsTable() {
		let collaboratorsTableView = CollaboratorsTableViewController()
		collaboratorsTableView.repository = repository
		
		navigationController?.pushViewController(collaboratorsTableView, animated: true)
	}
}

extension RepoViewController: SegmentCommitsBranchesTableViewCellDelegate {
	func setSegmentControllerValue(_ value: Int) {
		segmentControllerValue = value
	}
	
	func showWebView(at indexPath: IndexPath) {
//		let webView = SomeUrlWebViewController()
//		let newURL = repository?.commits?[indexPath.row].getUrlOfCommit() ?? ""
//		guard let url = URL(string: newURL) else { return }
//		webView.url = url
		
		let webView = Builder.createSomeWebView(with: repository?.commits?[indexPath.row].getUrlOfCommit() ?? "")
		self.navigationController?.pushViewController(webView, animated: true)
	}
}
