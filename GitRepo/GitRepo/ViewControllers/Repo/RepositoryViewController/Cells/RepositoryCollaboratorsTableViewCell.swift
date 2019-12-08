//
//  RepositoryCollaboratorsTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit Tests

protocol RepositoryCollaboratorsTableViewCellDelegate: class {
	/// Show Collaborators Table throw delegate
	func showCollaboratorsTable()
}

/// Shows label and button for view collaborators table
class RepositoryCollaboratorsTableViewCell: UITableViewCell {
	
	public static let collaboratorsReuseId = "CollaboratorsReuseId"
	public weak var delegate: RepositoryCollaboratorsTableViewCellDelegate!
	public var repository: Repository? {
		didSet {
			self.setupViews()
		}
	}
	
	private var collaboratorsButtonTitle = "Участники"
	private var collaboratorsLabel = UILabel()
	private var collaboratorsViewButton = UIButton()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		
		setupViews()
	}
	
	func setupViews() {
		
		// collaboratorsLabel
		collaboratorsLabel.numberOfLines = 0
		collaboratorsLabel.font = UIFont.systemFont(ofSize: 18)
		collaboratorsLabel.text = "Участники: "
		
		// collaboratorsViewButton
		if let numberOfCollaborators: Int = repository?.collaborators?.count {
			
			collaboratorsButtonTitle = "Участники: " + "\(numberOfCollaborators)"
		}
		collaboratorsViewButton.setTitle(collaboratorsButtonTitle, for: .normal)
		collaboratorsViewButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		collaboratorsViewButton.titleEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
		collaboratorsViewButton.layer.cornerRadius = 20
		collaboratorsViewButton.layer.masksToBounds = true
		collaboratorsViewButton.backgroundColor = .lightGray
		
		collaboratorsViewButton.setTitleColor(.blue, for: .normal)
		collaboratorsViewButton.setTitleColor(.white, for: .highlighted)
		collaboratorsViewButton.addTarget(self, action: #selector(collaboratorsButtonTapped), for: .touchUpInside)
		
		// add to contentView
		contentView.addSubview(collaboratorsLabel)
		contentView.addSubview(collaboratorsViewButton)
		
		// translatesAutoresizingMaskIntoConstraints
		collaboratorsLabel.translatesAutoresizingMaskIntoConstraints = false
		collaboratorsViewButton.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
		
		NSLayoutConstraint.activate([
			// repoOwnerLabel
			collaboratorsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			collaboratorsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			collaboratorsLabel.trailingAnchor.constraint(equalTo: collaboratorsViewButton.leadingAnchor, constant: -10),
			collaboratorsLabel.heightAnchor.constraint(equalToConstant: 80),
			collaboratorsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			// repoButton
			collaboratorsViewButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  30),
			collaboratorsViewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			collaboratorsViewButton.heightAnchor.constraint(equalToConstant: 40)
			
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

extension RepositoryCollaboratorsTableViewCell {
	
	/// Show Collaborators Table throw delegate
	@objc
	func collaboratorsButtonTapped() {
		delegate.showCollaboratorsTable()
		
	}
}
