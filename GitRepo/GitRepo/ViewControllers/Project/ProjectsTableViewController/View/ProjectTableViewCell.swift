//
//  ProjectTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 06/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// No Unit Tests

class ProjectTableViewCell: UITableViewCell {

	public static let reusedId = "ProjectsCellReuseId"
	
	public var project: Project? {
		didSet {
			self.setupViews()
		}
	}
	
	private var projectNameLabel = UILabel()
	private var projectLanguageLabel = UILabel()
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
		
		// projectNameLabel
		projectNameLabel.numberOfLines = 0
		projectNameLabel.font = UIFont.systemFont(ofSize: 16)
		projectNameLabel.textAlignment = .left
		projectNameLabel.text = project?.projectName
		
		projectLanguageLabel.numberOfLines = 0
//		projectLanguageLabel.font = UIFont.systemFont(ofSize: 16)
		projectLanguageLabel.font = UIFont.italicSystemFont(ofSize: 16)
		projectLanguageLabel.textAlignment = .left
		projectLanguageLabel.text = "Язык проекта: " + (project?.languageOfProject ?? "")
		
		// beautyfulView
		beautyfulView.addSubview(projectNameLabel)
		beautyfulView.addSubview(projectLanguageLabel)
		contentView.addSubview(beautyfulView)
		
		projectNameLabel.translatesAutoresizingMaskIntoConstraints = false
		projectLanguageLabel.translatesAutoresizingMaskIntoConstraints = false
		beautyfulView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
		
		// projectNameLabel
		NSLayoutConstraint.activate([
			projectNameLabel.topAnchor.constraint(equalTo: beautyfulView.topAnchor, constant:  10),
			projectNameLabel.leadingAnchor.constraint(equalTo: beautyfulView.leadingAnchor, constant: 20),
			projectNameLabel.trailingAnchor.constraint(equalTo: beautyfulView.trailingAnchor, constant: -20),
			projectNameLabel.heightAnchor.constraint(equalToConstant: 20)])
		
		// projectLanguageLabel
		NSLayoutConstraint.activate([
			projectLanguageLabel.topAnchor.constraint(equalTo: projectNameLabel.bottomAnchor, constant: 15),
			projectLanguageLabel.leadingAnchor.constraint(equalTo: beautyfulView.leadingAnchor, constant: 20),
			projectLanguageLabel.trailingAnchor.constraint(equalTo: beautyfulView.trailingAnchor, constant: -20),
			projectLanguageLabel.bottomAnchor.constraint(equalTo: beautyfulView.bottomAnchor, constant: -10),
			projectLanguageLabel.heightAnchor.constraint(equalToConstant: 20)
			])
		
		// beautyfulView
		NSLayoutConstraint.activate([
			beautyfulView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			beautyfulView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			beautyfulView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			beautyfulView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			beautyfulView.heightAnchor.constraint(equalToConstant: 80)
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
