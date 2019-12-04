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
	private var tableViewWithLabelsAndButtons: UITableView!
	
	private var tableForSegmentChoose: UITableView!
	
	var tableViewFrame: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .white
		title = repository?.name
		
		setupViews()
    }
	
	func setupViews() {
		
		tableViewFrame = CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.width, height: 315))
		
		tableViewWithLabelsAndButtons = UITableView(frame: tableViewFrame ?? CGRect.zero, style: .plain)
		tableViewWithLabelsAndButtons.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		tableViewWithLabelsAndButtons.separatorStyle = .none
		
		tableViewWithLabelsAndButtons.dataSource = self
		
		tableViewWithLabelsAndButtons.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		
		tableViewWithLabelsAndButtons.register(OwnerAndViewButtonTableViewCell.self, forCellReuseIdentifier: OwnerAndViewButtonTableViewCell.ownerReuseId)
		tableViewWithLabelsAndButtons.register(SegmentCommitsBranchesTableViewCell.self, forCellReuseIdentifier: SegmentCommitsBranchesTableViewCell.separatorCommitsBranchesReuseId)
		
		tableViewWithLabelsAndButtons.register(RepositoryCollaboratorsTableViewCell.self, forCellReuseIdentifier: RepositoryCollaboratorsTableViewCell.collaboratorsReuseId)
		tableViewWithLabelsAndButtons.register(RepositoryBranchesTableViewCell.self, forCellReuseIdentifier: RepositoryBranchesTableViewCell.branchesReuseId)
		
		view.addSubview(tableViewWithLabelsAndButtons)
		
		let tableForSegmentChooseViewFrame = CGRect(origin: CGPoint(x: view.frame.origin.x, y: 315), size: CGSize(width: view.frame.width, height: 315))
		tableForSegmentChoose = UITableView(frame: tableForSegmentChooseViewFrame, style: .plain)
		tableForSegmentChoose.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		
		tableForSegmentChoose.dataSource = self
		
		view.addSubview(tableForSegmentChoose)
		
	}
}

extension RepoViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView == tableViewWithLabelsAndButtons {
			return 3
		} else {
			return repository?.collaborators?.count ?? 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
//		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
//		switch indexPath.row {
//		case 0:
//			let cell = tableView.dequeueReusableCell(withIdentifier: OwnerAndViewButtonTableViewCell.ownerReuseId, for: indexPath) as! OwnerAndViewButtonTableViewCell
//			cell.repository = repository
//			cell.delegate = self
//			return cell
//
//		case 1:
//			let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCollaboratorsTableViewCell.collaboratorsReuseId, for: indexPath) as! RepositoryCollaboratorsTableViewCell
//			cell.repository = repository
//			return cell
//
//		case 2:
//			let cell = tableView.dequeueReusableCell(withIdentifier: SegmentCommitsBranchesTableViewCell.separatorCommitsBranchesReuseId, for: indexPath) as! SegmentCommitsBranchesTableViewCell
//			cell.repository = repository
//			return cell
		
//		case 3:
//			let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryBranchesTableViewCell.branchesReuseId.collaboratorsReuseId, for: indexPath) as! RepositoryBranchesTableViewCell
//			cell.repository = repository
//			return cell
//		default:
//			return cell
//		}
		if tableView == tableViewWithLabelsAndButtons {
			return createCellForTableView(tableView, indexPath: indexPath)
		} else {
			return createCellForSegmentedTableView(tableView, indexPath: indexPath)
		}
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
			cell.repository = repository
			return cell
			
		case 2:
			let cell = tableView.dequeueReusableCell(withIdentifier: SegmentCommitsBranchesTableViewCell.separatorCommitsBranchesReuseId, for: indexPath) as! SegmentCommitsBranchesTableViewCell
			cell.repository = repository
			return cell
		default:
			return cell
		}
	}
	
	func createCellForSegmentedTableView(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell{
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		let collaboratorsName = repository?.branches?[indexPath.row].name ?? ""
		cell.textLabel?.text = collaboratorsName
		
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
