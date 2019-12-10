//
//  OwnerAndViewButtonTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 03/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit Tests

protocol OwnerAndViewButtonTableViewCellDelegate: class {
	func tapRepoButton()
}

/**
Shows reporitory info and page in WebView
Unit Tests - [OwnerAndViewButtonTableViewCellTests](x-source-tag://OwnerAndViewButtonTableViewCellTests)
*/
class OwnerAndViewButtonTableViewCell: UITableViewCell {
	
	public static let ownerReuseId = "OwnerAndViewButtonReuseId"
	public weak var delegate: OwnerAndViewButtonTableViewCellDelegate!
	
	public var repository: Repository? {
		didSet {
			self.setupViews()
		}
	}
	
	private var repoButtonTitle = "Открыть в браузере"
	private var repoOwnerLabel = UILabel()
	private var repoViewButton = UIButton()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		
		setupViews()
	}
	
	func setupViews() {
		
		// repoOwnerLabel
		repoOwnerLabel.numberOfLines = 0
		repoOwnerLabel.font = UIFont.systemFont(ofSize: 18)
		repoOwnerLabel.text = "Владелец: "
		if let nameOfRepoOwner: String = repository?.owner?.login {
			repoOwnerLabel.text = "Владелец: " + nameOfRepoOwner.capitalized
		}
		
		// repoViewButton
		repoViewButton.setTitle(repoButtonTitle, for: .normal)
		repoViewButton.backgroundColor = .white
		repoViewButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
		repoViewButton.setTitleColor(.blue, for: .normal)
//		repoViewButton.setTitleColor(UIColor(red: 1, green: 0.6, blue: 0, alpha: 0.8), for: .normal)
		repoViewButton.setTitleColor(.white, for: .highlighted)
		repoViewButton.titleEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
		repoViewButton.layer.cornerRadius = 20
		repoViewButton.layer.masksToBounds = true
		repoViewButton.layer.borderColor = UIColor(red: 1, green: 0.6, blue: 0, alpha: 0.2).cgColor
		repoViewButton.layer.borderWidth = 1
		
		repoViewButton.addTarget(self, action: #selector(tapRepoViewButton), for: .touchUpInside)
		
		// add to contentView
		contentView.addSubview(repoOwnerLabel)
		contentView.addSubview(repoViewButton)
		
		// translatesAutoresizingMaskIntoConstraints
		repoOwnerLabel.translatesAutoresizingMaskIntoConstraints = false
		repoViewButton.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
		
		// repoOwnerLabel
		NSLayoutConstraint.activate([
			
			repoOwnerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			repoOwnerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			repoOwnerLabel.trailingAnchor.constraint(equalTo: repoViewButton.leadingAnchor, constant: -25),
			repoOwnerLabel.heightAnchor.constraint(equalToConstant: 80),
			repoOwnerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)])
		
		// repoViewButton
		NSLayoutConstraint.activate([
			repoViewButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  20),
			repoViewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			repoViewButton.heightAnchor.constraint(equalToConstant: 60)
			
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

extension OwnerAndViewButtonTableViewCell {
	
	/// Open repository in WebView throw delegate
	@objc
	func tapRepoViewButton() {
		delegate.tapRepoButton()
	}
}
