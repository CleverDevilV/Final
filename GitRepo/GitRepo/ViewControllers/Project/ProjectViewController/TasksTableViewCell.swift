//
//  TasksTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

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
	private var tasksView = UIView()
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
		//		descriptionLabel.textColor
		tasksLabel.text = "Задачи:"
		
		// tasksButton
		if let countOfTasks = project?.projectTasks?.count {
			tasksButton.setTitle("\(countOfTasks)", for: .normal)
		} else {
			tasksButton.setTitle("Нет задач", for: .normal)
		}
//		tasksButton.setTitle("▿", for: .normal)
		tasksButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
		tasksButton.setTitleColor(.blue, for: .normal)
		tasksButton.setTitleColor(.white, for: .highlighted)
		tasksButton.addTarget(self, action: #selector(taptasksButton), for: .touchUpInside)
		
	//tasksView
		tasksView.backgroundColor = .white
//		let table = TasksTableViewController()
//		tasksView.addSubview(table)
		
		// add to contentView
		contentView.addSubview(tasksLabel)
		contentView.addSubview(tasksButton)
//		contentView.addSubview(tasksView)
		
		// translatesAutoresizingMaskIntoConstraints
		tasksLabel.translatesAutoresizingMaskIntoConstraints = false
		tasksButton.translatesAutoresizingMaskIntoConstraints = false
//		tasksView.translatesAutoresizingMaskIntoConstraints = false
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
		
	//tasksView
//		NSLayoutConstraint.activate([
//			tasksView.topAnchor.constraint(equalTo: tasksLabel.bottomAnchor, constant: 20),
//			tasksView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//			tasksView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
//			tasksView.heightAnchor.constraint(equalToConstant: 300),
//			tasksView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
//			])
		
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
	func taptasksButton() {
		
//		if !isExtendedCollaborators {
//			tasksButton.titleLabel?.transform = CGAffineTransform(rotationAngle: .pi)
			//			heightOfCollaboratorsTable = 100
//		} else {
			//			heightOfCollaboratorsTable = 0
//			tasksButton.titleLabel?.transform = CGAffineTransform(rotationAngle: 0)
//		}
		
		isExtendedCollaborators = !isExtendedCollaborators
		delegate.addTasksTable()
	}
}
