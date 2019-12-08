//
//  LogoutSettingsTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 04/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit Tests

protocol LogoutSettingsTableViewCellDelegate: class {
	func logoutButtonTapped()
}

/// View with logout button
class LogoutSettingsTableViewCell: UITableViewCell {

	public static var reusedId = "LogoutSettingsTableViewCellDelegateReusedIdOfCell"
	public weak var delegate: LogoutSettingsTableViewCellDelegate!
	
	private var logoutButton = UIButton(type: .roundedRect)
	
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		
		setupViews()
	}
	
	func setupViews() {
	
		logoutButton.setTitle("Выйти", for: .normal)
		logoutButton.setTitleColor(.red, for: .normal)
		logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
		
		contentView.addSubview(logoutButton)
		
		logoutButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			logoutButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			logoutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
			logoutButton.widthAnchor.constraint(equalToConstant: 50),
			logoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
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

	@objc
	func logoutButtonTapped() {
		delegate.logoutButtonTapped()
	}
	
}
