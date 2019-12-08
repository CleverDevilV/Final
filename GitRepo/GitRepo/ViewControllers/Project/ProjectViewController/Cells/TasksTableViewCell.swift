//
//  TasksTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit Tests

protocol TasksTableViewCellDelegate: class {
	func addTasksTable()
}

class TasksTableViewCell: UITableViewCell {
	
	public static let tasksReuseId = "TasksReuseId"
	public weak var delegate: TasksTableViewCellDelegate!
	public var project: Project? {
		didSet {
			self.setupViews()
		}
	}
	
	private var tasksLabel = UILabel()
	private var tasksButton = UIButton()
	
	private var isExtendedCollaborators = false
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		setupViews()
	}
	
	func setupViews() {
		
		// tasksLabel
		tasksLabel.numberOfLines = 1
		tasksLabel.font = UIFont.systemFont(ofSize: 20)
		tasksLabel.text = "Задачи:"
		
		// tasksButton
		tasksButton.setImage(UIImage(named: "arrowDown"), for: .normal)
		tasksButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
		tasksButton.setTitleColor(.blue, for: .normal)
		tasksButton.setTitleColor(.white, for: .highlighted)
		tasksButton.addTarget(self, action: #selector(tapTasksButton), for: .touchUpInside)
		
		// add to contentView
		contentView.addSubview(tasksLabel)
		contentView.addSubview(tasksButton)
		
		// translatesAutoresizingMaskIntoConstraints
		tasksLabel.translatesAutoresizingMaskIntoConstraints = false
		tasksButton.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
	// tasksLabel
		NSLayoutConstraint.activate([
			tasksLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			tasksLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			tasksLabel.trailingAnchor.constraint(equalTo: tasksButton.leadingAnchor, constant: -10),
			tasksLabel.heightAnchor.constraint(equalToConstant: 40)
			])
		
	// tasksButton
		NSLayoutConstraint.activate([
			tasksButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			tasksButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
			tasksButton.heightAnchor.constraint(equalToConstant: 40)
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
		
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
	}
	
	/// Add table with tasks throw delegate
	@objc
	func tapTasksButton() {
		
		if !isExtendedCollaborators {
			tasksButton.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
		} else {
			tasksButton.imageView?.transform = CGAffineTransform(rotationAngle: 0)
		}
		
		isExtendedCollaborators = !isExtendedCollaborators
		delegate.addTasksTable()
	}
}
