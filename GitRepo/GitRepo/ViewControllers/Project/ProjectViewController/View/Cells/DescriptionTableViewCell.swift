//
//  DescriptionTableViewCell.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit Tests

protocol DescriptionTableViewCellDelegate: class {
	/// Update description in project
	func projectDescriptionUpdate(_ description: String?)
}

 /// Unit Tests - [DescriptionTableViewCellTests](x-source-tag://DescriptionTableViewCellTests)
class DescriptionTableViewCell: UITableViewCell {
	
	public static let descriptionReuseId = "DescriptionReuseId"
	public weak var descriptionCellDelegate: DescriptionTableViewCellDelegate!
	
	private var descriptionLabel = UILabel()
	public var descriptionTextView = UITextView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		self.backgroundColor = .clear
		
		setupViews()
	}
	
	func setupViews() {
		
	// descriptionLabel
		descriptionLabel.numberOfLines = 1
		descriptionLabel.font = UIFont.systemFont(ofSize: 20)
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
		descriptionTextView.delegate = self
		
	// add to contentView
		contentView.addSubview(descriptionLabel)
		contentView.addSubview(descriptionTextView)
		
	// translatesAutoresizingMaskIntoConstraints
		descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func updateConstraints() {
		// descriptionLabel
		NSLayoutConstraint.activate([
			descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			descriptionLabel.trailingAnchor.constraint(equalTo: descriptionTextView.leadingAnchor, constant: -10),
			descriptionLabel.heightAnchor.constraint(equalToConstant: 40)
			])
		
		// descriptionTextView
		NSLayoutConstraint.activate([
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
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		
    }
	
}

extension DescriptionTableViewCell: UITextViewDelegate {
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
		return newText.count <= 70
	}
	
	func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		let keypadToolbar: UIToolbar = UIToolbar()

		// add a done button to the numberpad
		keypadToolbar.items = [
			UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textView, action: #selector(UITextView.resignFirstResponder)),
			UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
		]
		keypadToolbar.sizeToFit()
		// add a toolbar with a done button above the number pad
		textView.inputAccessoryView = keypadToolbar
		return true
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		// Update description in project
		descriptionCellDelegate.projectDescriptionUpdate(textView.text)
	}
}
