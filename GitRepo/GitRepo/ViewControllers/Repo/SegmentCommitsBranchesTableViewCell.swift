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
//		segmentControl.sendActions(for: .valueChanged)
		
		// add to contentView
		contentView.addSubview(segmentControl)
		
		// translatesAutoresizingMaskIntoConstraints
		segmentControl.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
		
		NSLayoutConstraint.activate([
			// repoLabel
			segmentControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			segmentControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
			segmentControl.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20),
			segmentControl.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: -10),
			segmentControl.heightAnchor.constraint(equalToConstant: 30),
			segmentControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
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
	}
	
}
