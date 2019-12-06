//
//  RepositoryBranchesTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class RepositoryBranchesTableViewCell: UITableViewCell {
	
	public static let branchesReuseId = "BranchesReuseId"
	public weak var delegate: OwnerAndViewButtonTableViewCellDelegate!
	public var repository: Repository? {
		didSet {
			self.setupViews()
		}
	}
	
	private var repoButtonTitle = "Ветки: "
	private var repoOwnerLabel = UILabel()
	private var repoViewButton = UIButton()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		
		setupViews()
	}
	
	func setupViews() {
		
		// descriptionLabel
		repoOwnerLabel.numberOfLines = 0
		repoOwnerLabel.font = UIFont.systemFont(ofSize: 18)
		//		descriptionLabel.textColor
		repoOwnerLabel.text = "Ветки: "
		// repoButton
		if let nameOfRepoOwner: String = repository?.owner?.login {
			
			repoButtonTitle = "Ветки: " + nameOfRepoOwner.capitalized
		}
		
		repoViewButton.setTitle(repoButtonTitle, for: .normal)
		repoViewButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		repoViewButton.titleEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
		repoViewButton.layer.cornerRadius = 20
		repoViewButton.layer.masksToBounds = true
		repoViewButton.backgroundColor = .lightGray
		
		repoViewButton.setTitleColor(.blue, for: .normal)
		repoViewButton.setTitleColor(.white, for: .highlighted)
		//		repoViewButton.addTarget(self, action: #selector(tapRepoViewButton), for: .touchUpInside)
		
		// add to contentView
		contentView.addSubview(repoOwnerLabel)
		contentView.addSubview(repoViewButton)
		
		// translatesAutoresizingMaskIntoConstraints
		repoOwnerLabel.translatesAutoresizingMaskIntoConstraints = false
		repoViewButton.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
		
		NSLayoutConstraint.activate([
			// repoLabel
			repoOwnerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			repoOwnerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			repoOwnerLabel.trailingAnchor.constraint(equalTo: repoViewButton.leadingAnchor, constant: -10),
			repoOwnerLabel.heightAnchor.constraint(equalToConstant: 80),
			repoOwnerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			// repoButton
			repoViewButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  30),
			repoViewButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
			repoViewButton.heightAnchor.constraint(equalToConstant: 40)
			
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
