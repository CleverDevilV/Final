//
//  RepoTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

protocol RepoTableCellDelegate: class {
	func setupRepo()
}

class RepoTableViewCell: UITableViewCell {
	
	public static let repoReuseId = "RepoReuseId"
	public weak var delegate: RepoTableCellDelegate!
	public var project: Project? {
		didSet {
			self.setupViews()
		}
	}
	
	private var repoButtonTitle = "Нет"
	private var repoLabel = UILabel()
	private var repoButton = UIButton()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		
		setupViews()
	}
	
	func setupViews() {
		
	// descriptionLabel
		repoLabel.numberOfLines = 1
		repoLabel.font = UIFont.systemFont(ofSize: 20)
		//		descriptionLabel.textColor
		repoLabel.text = "Репозиторий:"
		
	// repoButton
		if let nameOfRepo: String = project?.repoUrl?.lastPathComponent {
			repoButtonTitle = nameOfRepo.capitalized
		}
		repoButton.setTitle(repoButtonTitle, for: .normal)
		repoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
		repoButton.setTitleColor(.blue, for: .normal)
		repoButton.setTitleColor(.white, for: .highlighted)
		repoButton.addTarget(self, action: #selector(tapRepoButton), for: .touchUpInside)
		
	// add to contentView
		contentView.addSubview(repoLabel)
		contentView.addSubview(repoButton)
		
	// translatesAutoresizingMaskIntoConstraints
		repoLabel.translatesAutoresizingMaskIntoConstraints = false
		repoButton.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
		
		NSLayoutConstraint.activate([
		// repoLabel
			repoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			repoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			repoLabel.trailingAnchor.constraint(equalTo: repoButton.leadingAnchor, constant: -10),
			repoLabel.heightAnchor.constraint(equalToConstant: 40),
		// repoButton
			repoButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			repoButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
			repoButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			repoButton.heightAnchor.constraint(equalToConstant: 40)
			
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

extension RepoTableViewCell {
	
	@objc
	func tapRepoButton() {
		delegate.setupRepo()
	}
}
