//
//  SeparatorCommitsBranchesTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

protocol SegmentCommitsBranchesTableViewCellDelegate: class {
	func setSegmentControllerValue(_ value: Int)
}

class SegmentCommitsBranchesTableViewCell: UITableViewCell {
	
	public static let separatorCommitsBranchesReuseId = "SeparatorCommitsBranchesReuseId"
	public weak var delegate: SegmentCommitsBranchesTableViewCellDelegate!
	public var repository: Repository? {
		didSet {
			self.setupViews()
		}
	}
	
	private var segmentControl = UISegmentedControl(items: ["Коммиты", "Ветки"])
	private var tableViewForCommitsOrBranches = UITableView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		
		setupViews()
	}
	
	func setupViews() {
		
//		let titles = ["Коммиты", "Ветки"]
//		segmentControl = UISegmentedControl(items: titles)
		segmentControl.tintColor = UIColor(red: 0, green: 0.4784313725, blue: 1, alpha: 1) // #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
		segmentControl.selectedSegmentIndex = 0
		for index in 0...1 {
			segmentControl.setWidth(120, forSegmentAt: index)
		}
		segmentControl.sizeToFit()
		segmentControl.selectedSegmentIndex = 0
		segmentControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
		
		
		tableViewForCommitsOrBranches.backgroundColor = .white
		tableViewForCommitsOrBranches.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

		tableViewForCommitsOrBranches.dataSource = self
		tableViewForCommitsOrBranches.delegate = self
		
		// add to contentView
		contentView.addSubview(segmentControl)
		contentView.addSubview(tableViewForCommitsOrBranches)
		
		// translatesAutoresizingMaskIntoConstraints
		segmentControl.translatesAutoresizingMaskIntoConstraints = false
		tableViewForCommitsOrBranches.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
		
		NSLayoutConstraint.activate([
			// repoLabel
			segmentControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			segmentControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
			segmentControl.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20),
			segmentControl.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: -10),
			segmentControl.heightAnchor.constraint(equalToConstant: 30)
			])
		
		NSLayoutConstraint.activate([
			tableViewForCommitsOrBranches.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
			tableViewForCommitsOrBranches.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			tableViewForCommitsOrBranches.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			tableViewForCommitsOrBranches.heightAnchor.constraint(equalToConstant: 300),
			tableViewForCommitsOrBranches.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			])
		
		super.updateConstraints()
	}
	
	override class var requiresConstraintBasedLayout: Bool {
		return true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	@objc
	func segmentValueChanged() {
		delegate.setSegmentControllerValue(segmentControl.selectedSegmentIndex)
		tableViewForCommitsOrBranches.reloadData()
	}
	
}

extension SegmentCommitsBranchesTableViewCell: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if segmentControl.selectedSegmentIndex == 0 {
			return repository?.commits?.count ?? 0
		} else {
			return repository?.branches?.count ?? 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		switch segmentControl.selectedSegmentIndex {
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
		
//		cell.textLabel?.text = "\(indexPath)"
		
		return cell
	}
}

extension SegmentCommitsBranchesTableViewCell: UITableViewDelegate {
	
}
