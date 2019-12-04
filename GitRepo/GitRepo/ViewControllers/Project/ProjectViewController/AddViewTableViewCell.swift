//
//  AddViewTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 04/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class AddViewTableViewCell: UITableViewCell {
	
	public static var reusedId = "AddViewTableViewCell"
	public var project: Project?
	public var arrayOfDataForPresent: [Any]? {
		didSet {
//			self.setupViews()
			self.defaultView.reloadData()
//			self.setupViews()
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
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}

}

extension AddViewTableViewCell: UITableViewDataSource {
	
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrayOfDataForPresent?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		if let arrayOfDataForPresent = arrayOfDataForPresent as? [User] {
			cell.textLabel?.text = arrayOfDataForPresent[indexPath.row].login
		} else if let arrayOfDataForPresent = arrayOfDataForPresent as? [String] {
			cell.textLabel?.text = arrayOfDataForPresent[indexPath.row]
		}
		
		return cell
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		let numberOfSections = arrayOfDataForPresent == nil ? 0 : 1
		return numberOfSections
	}
	
}

extension AddViewTableViewCell: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// TODO: редактирование текста по нажатию
		tableView.cellForRow(at: indexPath)?.isSelected = false
		
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if (arrayOfDataForPresent as? [User]) != nil {
			return 0
		} else if (arrayOfDataForPresent as? [String]) != nil {
			return 50
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		if (arrayOfDataForPresent as? [User]) != nil {
			return nil
		} else if (arrayOfDataForPresent as? [String]) != nil {
			
			let frame: CGRect = defaultView.frame
			let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
			headerView.layer.cornerRadius = 20
			headerView.layer.masksToBounds = true
			headerView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			
			let addTaskButton = UIButton(type: .contactAdd)
			addTaskButton.frame = CGRect(x: frame.width - 50, y: 10, width: 30, height: 30)
			addTaskButton.setTitleColor(.orange, for: .normal)
			addTaskButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
			
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
	func buttonTapped() {
		project?.addTask("task")
		arrayOfDataForPresent = project?.projectTasks
		defaultView.reloadData()
	}
	
	@objc private func toggleEditing(_ sender: UIButton) {
		defaultView.setEditing(!defaultView.isEditing, animated: true)
		sender.setTitle(defaultView.isEditing ? "Done" : "Edit", for: .normal)
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		
		if (arrayOfDataForPresent as? [User]) != nil {
			return UITableViewCell.EditingStyle.none
		} else if (arrayOfDataForPresent as? [String]) != nil {
			return UITableViewCell.EditingStyle.delete
		}
		
		return UITableViewCell.EditingStyle.none
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		
		if (arrayOfDataForPresent as? [User]) != nil {
			return false
		} else if (arrayOfDataForPresent as? [String]) != nil {
			return true
		}
		
		return false
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			project?.removeTask(at: indexPath.row)
			arrayOfDataForPresent = project?.projectTasks
			self.defaultView.reloadData()
		}
	}
}
