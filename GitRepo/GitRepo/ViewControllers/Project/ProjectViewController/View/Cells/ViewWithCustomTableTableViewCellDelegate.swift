//
//  AddViewTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 04/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit tests

protocol ViewWithCustomTableTableViewCellDelegate: class {
	func addTask()
}

enum TypeOfData {
	case collaborators
	case tasks
}

/// Class for create table in cell
 /// Unit Tests - [ViewWithCustomTableTableViewCellTests](x-source-tag://ViewWithCustomTableTableViewCellTests)
class ViewWithCustomTableTableViewCell: UITableViewCell {
	
	public static var reusedId = "AddViewTableViewCell"
	
	public weak var addTaskDelegate: ViewWithCustomTableTableViewCellDelegate!
	public var project: Project?
	
	public var arrayOfDataForPresent: [Decodable]? {
		didSet {
			self.setupViews()
		}
	}
	
	public var typeOfData: TypeOfData? {
		didSet {
			self.setupViews()
		}
	}
	
	private var defaultView = UITableView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		
		defaultView.dataSource = self
		defaultView.delegate = self
		
		setupViews()
	}
	
	func setupViews() {
		
		self.defaultView.reloadData()
		
		defaultView.backgroundColor = .white
		defaultView.layer.cornerRadius = 20
		defaultView.layer.masksToBounds = true
		defaultView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		
		contentView.addSubview(defaultView)
		
		defaultView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			defaultView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			defaultView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			defaultView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			defaultView.heightAnchor.constraint(equalToConstant: 200),
			defaultView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
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

}

extension ViewWithCustomTableTableViewCell: UITableViewDataSource {
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrayOfDataForPresent?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		switch typeOfData {
		case .collaborators?:
			if let arrayOfDataForPresent = arrayOfDataForPresent as? [User] {
				cell.textLabel?.text = arrayOfDataForPresent[indexPath.row].login
			}
		case .tasks?:
			if let arrayOfDataForPresent = arrayOfDataForPresent as? [String] {
				cell.textLabel?.text = arrayOfDataForPresent[indexPath.row]
			}
		case .none:
			return cell
		}
		
//		if typeOfData == "collaborators" {
//
//		} else if typeOfData == "tasks", let arrayOfDataForPresent = arrayOfDataForPresent as? [String] {
//			cell.textLabel?.text = arrayOfDataForPresent[indexPath.row]
//		}
		
		return cell
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
}

extension ViewWithCustomTableTableViewCell: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// TODO: редактирование текста по нажатию
		tableView.cellForRow(at: indexPath)?.isSelected = false
		
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		switch typeOfData {
		case .collaborators?:
			return 0
		case .tasks?:
			return 50
		case .none:
			return 0
		}
//		if typeOfData == "collaborators" {
//			return 0
//		} else if typeOfData == "tasks" {
//			return 50
//		}
//		return 0
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		if typeOfData == .collaborators {
			return nil
		} else if typeOfData == .tasks {
			
			let frame: CGRect = defaultView.frame
			let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
			headerView.layer.cornerRadius = 20
			headerView.layer.masksToBounds = true
			headerView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			
			let addTaskButton = UIButton(type: .contactAdd)
			addTaskButton.frame = CGRect(x: frame.width - 50, y: 10, width: 30, height: 30)
			addTaskButton.setTitleColor(.orange, for: .normal)
			addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
			
			let editTasksButton = UIButton(frame: CGRect(x: frame.width - 110, y: 10, width: 50, height: 30))
			editTasksButton.setTitle("Edit", for: .normal)
			editTasksButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
			editTasksButton.setTitleColor(.orange, for: .normal)
			editTasksButton.addTarget(self, action: #selector(toggleEditing(_:)), for: .touchUpInside)
			
			headerView.addSubview(addTaskButton)
			headerView.addSubview(editTasksButton)
			
			return headerView
		}
		return nil
	}
	
	@objc
	func addTaskButtonTapped() {
		
		addTaskDelegate.addTask()
		
		defaultView.reloadData()
	}
	
	@objc private func toggleEditing(_ sender: UIButton) {
		defaultView.setEditing(!defaultView.isEditing, animated: true)
		sender.setTitle(defaultView.isEditing ? "Done" : "Edit", for: .normal)
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		
		switch typeOfData {
		case .collaborators?:
			return UITableViewCell.EditingStyle.none
		case .tasks?:
			return UITableViewCell.EditingStyle.delete
		case .none:
			return UITableViewCell.EditingStyle.none
		}
		
//		if typeOfData == "collaborators" {
//			return UITableViewCell.EditingStyle.none
//		} else if typeOfData == "tasks" {
//			return UITableViewCell.EditingStyle.delete
//		}
		
//		return UITableViewCell.EditingStyle.none
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		
		switch typeOfData {
		case .collaborators?:
			return false
		case .tasks?:
			return true
		case .none:
			return false
		}
		
//		if typeOfData == "collaborators" {
//			return false
//		} else if typeOfData == "tasks" {
//			return true
//		}
		
//		return false
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			project?.removeTask(at: indexPath.row)
			arrayOfDataForPresent = project?.projectTasks
			self.defaultView.reloadData()
		}
	}
}
