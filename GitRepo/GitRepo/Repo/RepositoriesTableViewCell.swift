//
//  RepositoriesTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 02/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

final class RepositoriesTableViewCell: UITableViewCell {
	
	public static let repositoriesCellReuseId = "RepositoriesCellReuseId"
	public var repository: Repository? {
		didSet {
			self.setupViews()
		}
	}
	
	private var repositiryNameLabel = UILabel()
	private var lastChangesLabel = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		
		setupViews()
	}
	
	func setupViews() {
		
		// descriptionLabel
		repositiryNameLabel.numberOfLines = 0
		repositiryNameLabel.font = UIFont.systemFont(ofSize: 16)
		repositiryNameLabel.textAlignment = .left
		repositiryNameLabel.text = repository?.name
		
		lastChangesLabel.numberOfLines = 0
		lastChangesLabel.font = UIFont.systemFont(ofSize: 16)
		lastChangesLabel.textAlignment = .left
		// TODO: - Дата последних изменений
		lastChangesLabel.text = "Дата последних изменений:"
		
		contentView.addSubview(repositiryNameLabel)
		contentView.addSubview(lastChangesLabel)
		
		repositiryNameLabel.translatesAutoresizingMaskIntoConstraints = false
		lastChangesLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
	
		// repositiryNameLabel
		NSLayoutConstraint.activate([
			repositiryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			repositiryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			repositiryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			repositiryNameLabel.heightAnchor.constraint(equalToConstant: 20)])
		
			
		// lastChangesLabel
		NSLayoutConstraint.activate([
			lastChangesLabel.topAnchor.constraint(equalTo: repositiryNameLabel.bottomAnchor, constant:  15),
			lastChangesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			lastChangesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			lastChangesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			lastChangesLabel.heightAnchor.constraint(equalToConstant: 20)
			
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
