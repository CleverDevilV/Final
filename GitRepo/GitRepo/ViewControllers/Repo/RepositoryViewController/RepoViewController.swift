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
	private var segmentControllerValue: Int?
	
	private var tableViewWithLabelsAndButtons = UITableView()
	
//	private var tableForSegmentChoose: UITableView!
	

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
		
//		tableViewFrame = CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.width, height: 315))
		
		tableViewWithLabelsAndButtons = UITableView(frame: CGRect.zero, style: .plain)
		tableViewWithLabelsAndButtons.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		tableViewWithLabelsAndButtons.separatorStyle = .none
		
		tableViewWithLabelsAndButtons.dataSource = self
		
		tableViewWithLabelsAndButtons.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		
		tableViewWithLabelsAndButtons.register(OwnerAndViewButtonTableViewCell.self, forCellReuseIdentifier: OwnerAndViewButtonTableViewCell.ownerReuseId)
		tableViewWithLabelsAndButtons.register(RepositoryCollaboratorsTableViewCell.self, forCellReuseIdentifier: RepositoryCollaboratorsTableViewCell.collaboratorsReuseId)
		tableViewWithLabelsAndButtons.register(SegmentCommitsBranchesTableViewCell.self, forCellReuseIdentifier: SegmentCommitsBranchesTableViewCell.separatorCommitsBranchesReuseId)
		
		
//		tableViewWithLabelsAndButtons.register(RepositoryBranchesTableViewCell.self, forCellReuseIdentifier: RepositoryBranchesTableViewCell.branchesReuseId)
		
		tableViewWithLabelsAndButtons.register(AddViewTableViewCell.self, forCellReuseIdentifier: AddViewTableViewCell.reusedId)
		
		view.addSubview(tableViewWithLabelsAndButtons)
		
//		let tableForSegmentChooseViewFrame = CGRect(origin: CGPoint(x: view.frame.origin.x, y: 315), size: CGSize(width: view.frame.width, height: 315))
//		tableForSegmentChoose = UITableView(frame: CGRect.zero, style: .plain)
//		tableForSegmentChoose.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//
//		tableForSegmentChoose.dataSource = self
//		tableForSegmentChoose.delegate = self
//
//		view.addSubview(tableForSegmentChoose)
		
		addConstraints()
		
	}
	
	func addConstraints() {
		
		let safeArea = view.safeAreaLayoutGuide
		
		tableViewWithLabelsAndButtons.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			tableViewWithLabelsAndButtons.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
			tableViewWithLabelsAndButtons.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
			tableViewWithLabelsAndButtons.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
//			tableViewWithLabelsAndButtons.heightAnchor.constraint(equalToConstant: 250)
			tableViewWithLabelsAndButtons.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
			])
		
//		tableForSegmentChoose.translatesAutoresizingMaskIntoConstraints = false
//
//		NSLayoutConstraint.activate([
//			tableForSegmentChoose.topAnchor.constraint(equalTo: tableViewWithLabelsAndButtons.bottomAnchor, constant: 0),
//			tableForSegmentChoose.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
//			tableForSegmentChoose.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
//			tableForSegmentChoose.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
//			])
		
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
			cell.delegate = self
			return cell
//		case 3:
//			let cell = tableView.dequeueReusableCell(withIdentifier: AddViewTableViewCell.reusedId, for: indexPath) as! AddViewTableViewCell
			
//			cell.repository = repository
//			cell.delegate = self
//			return cell
		default:
			return cell
		}
	}
	
	func createCellForSegmentedTableView(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell{
		var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		switch segmentControllerValue {
		case nil, 0:
			let commitMessage = repository?.commits?[indexPath.row].message ?? ""
			let commitDate = repository?.commits?[indexPath.row].getCommitDate()
			
			cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
			cell.textLabel?.text = commitMessage
			cell.textLabel?.numberOfLines = 0
			cell.accessoryType = .disclosureIndicator
			cell.detailTextLabel?.text = "\(commitDate!)"
		default:
			let brancheName = repository?.branches?[indexPath.row].name ?? ""
			cell.textLabel?.text = brancheName
			cell.accessoryType = .none
		}
		
		
		
		return cell
	}
	
}

extension RepoViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		if tableView == tableForSegmentChoose {
//			tableView.cellForRow(at: indexPath)?.isSelected = false
//
//			let webView = SomeUrlWebViewController()
////			guard let url = URL(string: repository?.commits?[indexPath.row].url ?? "") else { return }
//			let newURL = repository?.commits?[indexPath.row].getUrlOfCommit() ?? ""
//			guard let url = URL(string: newURL) else { return }
//			webView.url = url
//			self.navigationController?.pushViewController(webView, animated: true)
//		}
		
	}
}

extension RepoViewController: OwnerAndViewButtonTableViewCellDelegate {
	func tapRepoButton() {
		let view = SomeUrlWebViewController()
		view.url = URL(string: self.repository?.repoLink ?? "")
		self.navigationController?.pushViewController(view, animated: true)
	}
}

extension RepoViewController: SegmentCommitsBranchesTableViewCellDelegate {
	func setSegmentControllerValue(_ value: Int) {
		segmentControllerValue = value
//		self.tableForSegmentChoose.reloadData()
	}
	
	func showWebView(at indexPath: IndexPath) {
		let webView = SomeUrlWebViewController()
		let newURL = repository?.commits?[indexPath.row].getUrlOfCommit() ?? ""
		guard let url = URL(string: newURL) else { return }
		webView.url = url
		self.navigationController?.pushViewController(webView, animated: true)
	}
}
