//
//  DescriptionTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
	
	public static let descriptionReuseId = "DescriptionReuseId"
	
	private var descriptionLabel = UILabel()
	private var descriptionTextView = UITextView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		
		setupViews()
	}
	
	func setupViews() {
		
	// descriptionLabel
		descriptionLabel.numberOfLines = 1
		descriptionLabel.font = UIFont.systemFont(ofSize: 20)
		//		descriptionLabel.textColor
		descriptionLabel.text = "Описание:"
		
	// descriptionTextView
		descriptionTextView.layer.borderColor = UIColor(red: 1, green: 0.6, blue: 0, alpha: 0.2).cgColor
		descriptionTextView.layer.borderWidth = 1
		descriptionTextView.textAlignment = .left
		descriptionTextView.backgroundColor = .white
		descriptionTextView.font = UIFont.systemFont(ofSize: 20)
		descriptionTextView.layer.cornerRadius = 25
		descriptionTextView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
		descriptionTextView.isScrollEnabled = false
		descriptionTextView.text = """
		Tratata
		Tratata
		"""
		descriptionTextView.delegate = self
		
	// add to contentView
		contentView.addSubview(descriptionLabel)
		contentView.addSubview(descriptionTextView)
		
	// translatesAutoresizingMaskIntoConstraints
		descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
		
		NSLayoutConstraint.activate([
		// descriptionLabel
			descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			descriptionLabel.trailingAnchor.constraint(equalTo: descriptionTextView.leadingAnchor, constant: -10),
			descriptionLabel.heightAnchor.constraint(equalToConstant: 40),
		// descriptionTextView
			descriptionTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			descriptionTextView.heightAnchor.constraint(equalToConstant: 100)
			
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

extension DescriptionTableViewCell: UITextViewDelegate {
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
		return newText.count <= 70
	}
	
	// чтобы была ссылка?
//	func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//		//и здесь пишете что-то типа такого
//		if URL.scheme == "ваше слово" {
//			// делаете что надо
//			return true
//		}
//		return false
//	}
}
