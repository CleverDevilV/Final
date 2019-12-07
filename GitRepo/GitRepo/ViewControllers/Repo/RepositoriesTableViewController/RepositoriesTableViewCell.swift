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
	private var beautyfulView = UIView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		
		setupViews()
	}
	
	func setupViews() {
		
		beautyfulView.backgroundColor = .white
		beautyfulView.layer.cornerRadius = 20
		beautyfulView.layer.borderColor = UIColor(red: 1, green: 0.6, blue: 0, alpha: 0.2).cgColor
		beautyfulView.layer.borderWidth = 1
		beautyfulView.layer.masksToBounds = true
		
		// descriptionLabel
		repositiryNameLabel.numberOfLines = 0
		repositiryNameLabel.font = UIFont.systemFont(ofSize: 16)
		repositiryNameLabel.textAlignment = .left
		repositiryNameLabel.text = repository?.name
		
		lastChangesLabel.numberOfLines = 0
		lastChangesLabel.font = UIFont.systemFont(ofSize: 16)
		lastChangesLabel.textAlignment = .left
		lastChangesLabel.text =
			"""
			Дата последнего изменения: \(repository?.getRepositoryDateString() ?? "")
			"""
		
		
		beautyfulView.addSubview(repositiryNameLabel)
		beautyfulView.addSubview(lastChangesLabel)
		contentView.addSubview(beautyfulView)
		
//		contentView.addSubview(repositiryNameLabel)
//		contentView.addSubview(lastChangesLabel)
		
		repositiryNameLabel.translatesAutoresizingMaskIntoConstraints = false
		lastChangesLabel.translatesAutoresizingMaskIntoConstraints = false
		beautyfulView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
	
		
		
		// repositiryNameLabel
//		NSLayoutConstraint.activate([
//			repositiryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
//			repositiryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//			repositiryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//			repositiryNameLabel.heightAnchor.constraint(equalToConstant: 20)])
		
		NSLayoutConstraint.activate([
			repositiryNameLabel.topAnchor.constraint(equalTo: beautyfulView.topAnchor, constant:  10),
			repositiryNameLabel.leadingAnchor.constraint(equalTo: beautyfulView.leadingAnchor, constant: 20),
			repositiryNameLabel.trailingAnchor.constraint(equalTo: beautyfulView.trailingAnchor, constant: -20),
			repositiryNameLabel.heightAnchor.constraint(equalToConstant: 20)])
		
			
		// lastChangesLabel
//		NSLayoutConstraint.activate([
//			lastChangesLabel.topAnchor.constraint(equalTo: repositiryNameLabel.bottomAnchor, constant:  15),
//			lastChangesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//			lastChangesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//			lastChangesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
//			lastChangesLabel.heightAnchor.constraint(equalToConstant: 40)
//			])
		NSLayoutConstraint.activate([
			lastChangesLabel.topAnchor.constraint(equalTo: repositiryNameLabel.bottomAnchor, constant:  15),
			lastChangesLabel.leadingAnchor.constraint(equalTo: beautyfulView.leadingAnchor, constant: 20),
			lastChangesLabel.trailingAnchor.constraint(equalTo: beautyfulView.trailingAnchor, constant: -20),
			lastChangesLabel.bottomAnchor.constraint(equalTo: beautyfulView.bottomAnchor, constant: -10),
			lastChangesLabel.heightAnchor.constraint(equalToConstant: 40)
			])
		
		// beautyfulView
		NSLayoutConstraint.activate([
			beautyfulView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			beautyfulView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			beautyfulView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			beautyfulView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			beautyfulView.heightAnchor.constraint(equalToConstant: 100)
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
