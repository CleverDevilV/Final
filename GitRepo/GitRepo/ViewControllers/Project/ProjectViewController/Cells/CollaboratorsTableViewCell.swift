//
//  CollaboratorsTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit Tests

protocol CollaboratorsTableViewCellDelegate: class {
	func addCollaboratorsTable()
}

class CollaboratorsTableViewCell: UITableViewCell {
	
	public static let collaboratorsReuseId = "CollaboratorsReuseId"
	public weak var delegate: CollaboratorsTableViewCellDelegate!
	
	private var collaboratorsLabel = UILabel()
	private var collaboratorsButton = UIButton()
	private var collaboratorsTableView = UIView()//UITableView()
	private var isExtendedCollaborators = false
	private var collaboratorsTableViewHeight: NSLayoutConstraint!
	private var heightOfCollaboratorsTable: CGFloat = 0
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		setupViews()
	}
	
	func setupViews() {
		
		// collaboratorsLabel
		collaboratorsLabel.numberOfLines = 1
		collaboratorsLabel.font = UIFont.systemFont(ofSize: 20)
		//		collaboratorsLabel.textColor
		collaboratorsLabel.text = "Участники:"
		
		// collaboratorsButton
//		collaboratorsButton.setTitle("▿", for: .normal)
		collaboratorsButton.setImage(UIImage(named: "arrowDown"), for: .normal)
		collaboratorsButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
		collaboratorsButton.setTitleColor(.blue, for: .normal)
		collaboratorsButton.setTitleColor(.white, for: .highlighted)
		collaboratorsButton.addTarget(self, action: #selector(tapCollaboratorsButton), for: .touchUpInside)
		
		// collaboratorsTableView
		collaboratorsTableView.backgroundColor = .white
		collaboratorsTableViewHeight = collaboratorsTableView.heightAnchor.constraint(equalToConstant: heightOfCollaboratorsTable)
		
		// add to contentView
		contentView.addSubview(collaboratorsLabel)
		contentView.addSubview(collaboratorsButton)
		contentView.addSubview(collaboratorsTableView)
		
		// translatesAutoresizingMaskIntoConstraints
		collaboratorsLabel.translatesAutoresizingMaskIntoConstraints = false
		collaboratorsButton.translatesAutoresizingMaskIntoConstraints = false
		collaboratorsTableView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
		
		
		
		NSLayoutConstraint.activate([
		// collaboratorsLabel
			collaboratorsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			collaboratorsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			collaboratorsLabel.trailingAnchor.constraint(equalTo: collaboratorsButton.leadingAnchor, constant: -10),
			collaboratorsLabel.heightAnchor.constraint(equalToConstant: 40),
		// collaboratorsButton
			collaboratorsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			collaboratorsButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
			collaboratorsButton.heightAnchor.constraint(equalToConstant: 40),
			collaboratorsButton.bottomAnchor.constraint(equalTo: collaboratorsTableView.topAnchor, constant: 15),
			
			// collaboratorsTableView
//			collaboratorsTableView.topAnchor.constraint(equalTo: collaboratorsButton.bottomAnchor, constant: 15),
			collaboratorsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			collaboratorsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			collaboratorsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			collaboratorsTableViewHeight
			
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

extension CollaboratorsTableViewCell {
	@objc
	func tapCollaboratorsButton() {
		
		if !isExtendedCollaborators {
			collaboratorsButton.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
			
		} else {
			
			collaboratorsButton.imageView?.transform = CGAffineTransform(rotationAngle: 0)
		}
		isExtendedCollaborators = !isExtendedCollaborators
		delegate.addCollaboratorsTable()
	}
}
