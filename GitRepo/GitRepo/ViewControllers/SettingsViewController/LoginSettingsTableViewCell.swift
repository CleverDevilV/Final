//
//  LoginSettingsTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 04/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class LoginSettingsTableViewCell: UITableViewCell {

	public static var reusedId = "LoginSettingsTableViewCellReusedIdOfCell"
	
	private var userLoginLabel = UILabel()
	
	
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		
		setupViews()
	}
	
	func setupViews() {
		
		userLoginLabel.text = "Логин: " + UserDefaults.standard.get(with: .oauth_user_login)
		userLoginLabel.font = UIFont.systemFont(ofSize: 18)
		
		contentView.addSubview(userLoginLabel)
		
		userLoginLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			userLoginLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			userLoginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			userLoginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			userLoginLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
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
