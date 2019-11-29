//
//  ProjectVC.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class ProjectVC: UIViewController {
	
	var project: Project?
	
	var descriptionLabel = UILabel()
	var descriptionTextField = UITextView()
	
	var repoLabel = UILabel()
	var repoButton = UIButton()
	
	var listOfCollaboratorsLabel = UILabel()
	var collaboratorsButton = UIButton()
	var collaboratorsTableView = UIView()
	var heightOfCollaboratorsTable: CGFloat = 0
	
	var listOfTasksLabel = UILabel()
	var tasksButton = UIButton()
	var tasksTableView = UITableView()
	var heightOfTasksTable: CGFloat = 0
	

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
		title = "Project"//project?.projectName
		
		setupViews()
    }
	
	func setupViews() {
		let safeArea = view.safeAreaLayoutGuide
		
		self.view.addSubview(descriptionLabel)
		self.view.addSubview(descriptionTextField)
		
		self.view.addSubview(repoLabel)
		self.view.addSubview(repoButton)
		
		self.view.addSubview(listOfCollaboratorsLabel)
		self.view.addSubview(collaboratorsButton)
		self.view.addSubview(collaboratorsTableView)
		
		self.view.addSubview(listOfTasksLabel)
		self.view.addSubview(tasksButton)
		self.view.addSubview(tasksTableView)
		
		descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
		
		repoLabel.translatesAutoresizingMaskIntoConstraints = false
		repoButton.translatesAutoresizingMaskIntoConstraints = false
		
		listOfCollaboratorsLabel.translatesAutoresizingMaskIntoConstraints = false
		collaboratorsButton.translatesAutoresizingMaskIntoConstraints = false
		collaboratorsTableView.translatesAutoresizingMaskIntoConstraints = false
		
		listOfTasksLabel.translatesAutoresizingMaskIntoConstraints = false
		tasksButton.translatesAutoresizingMaskIntoConstraints = false
		tasksTableView.translatesAutoresizingMaskIntoConstraints = false
		
		// descriptionLabel
		descriptionLabel.text = "Описание:"
		descriptionLabel.textAlignment = .left
		descriptionLabel.font = UIFont.systemFont(ofSize: 20)
		
		descriptionLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20).isActive = true
		descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
		descriptionLabel.trailingAnchor.constraint(equalTo: descriptionTextField.leadingAnchor, constant: -10).isActive = true
		
		// descriptionTextField
		
		descriptionTextField.textAlignment = .left
		descriptionTextField.font = UIFont.systemFont(ofSize: 20)
		descriptionTextField.layer.cornerRadius = 25
		descriptionTextField.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		descriptionTextField.isScrollEnabled = false
		descriptionTextField.delegate = self
		
		let descriptionTextFieldWidth: CGFloat = safeArea.layoutFrame.size.width - descriptionLabel.frame.size.width - 130
		
		descriptionTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
		descriptionTextField.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 10).isActive = true
		descriptionTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
		descriptionTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: descriptionTextFieldWidth).isActive = true
		descriptionTextField.heightAnchor.constraint(equalToConstant: 100).isActive = true
		
		// repoLabel
		
		repoLabel.text = "Репозиторий:"
		repoLabel.textAlignment = .left
		repoLabel.font = UIFont.systemFont(ofSize: 20)
		
		repoLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 25).isActive = true
		repoLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
		repoLabel.trailingAnchor.constraint(equalTo: repoButton.leadingAnchor, constant: 10)
		
		// repoButton
	
//		let title = "Repos"
//		let attributeString = NSMutableAttributedString(string: title)
//		attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, title.count))
//		attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(0, title.count))
//		repoButton.titleLabel?.attributedText = attributeString
		
		repoButton.setTitle("Repo", for: .normal)
		repoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
		repoButton.setTitleColor(.blue, for: .normal)
		repoButton.setTitleColor(.white, for: .highlighted)
		
		repoButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 15).isActive = true
		repoButton.leadingAnchor.constraint(equalTo: repoLabel.trailingAnchor, constant: 10).isActive = true
		repoButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
		repoButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		
		// listOfCollaboratorsLabel
		listOfCollaboratorsLabel.text = "Участники:"
		listOfCollaboratorsLabel.textAlignment = .left
		listOfCollaboratorsLabel.font = UIFont.systemFont(ofSize: 20)
		
		listOfCollaboratorsLabel.topAnchor.constraint(equalTo: repoLabel.bottomAnchor, constant: 25).isActive = true
		listOfCollaboratorsLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
		listOfCollaboratorsLabel.trailingAnchor.constraint(equalTo: collaboratorsButton.leadingAnchor, constant: 10)
		
		// collaboratorsButton
		
		collaboratorsButton.addTarget(self, action: #selector(collaboratorsListOpen), for: .touchUpInside)
		collaboratorsButton.setTitle("▿", for: .normal)
		collaboratorsButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
		collaboratorsButton.setTitleColor(.blue, for: .normal)
		collaboratorsButton.setTitleColor(.white, for: .highlighted)
		
		collaboratorsButton.topAnchor.constraint(equalTo: repoLabel.bottomAnchor, constant: 15).isActive = true
		collaboratorsButton.leadingAnchor.constraint(equalTo: listOfCollaboratorsLabel.trailingAnchor, constant: 10).isActive = true
		collaboratorsButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
		collaboratorsButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		// collaboratorsTable
		collaboratorsTableView.topAnchor.constraint(equalTo: listOfCollaboratorsLabel.bottomAnchor, constant: 15).isActive = true
		collaboratorsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
		collaboratorsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
		collaboratorsTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
		
		// listOfTasksLabel
		listOfTasksLabel.text = "Задачи:"
		listOfTasksLabel.textAlignment = .left
		listOfTasksLabel.font = UIFont.systemFont(ofSize: 20)

		listOfTasksLabel.topAnchor.constraint(equalTo: collaboratorsTableView.bottomAnchor, constant: 25).isActive = true
		listOfTasksLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
		listOfTasksLabel.trailingAnchor.constraint(equalTo: tasksButton.leadingAnchor, constant: 10)
		
		// tasksButton
		
		tasksButton.setTitle("▿", for: .normal)
		tasksButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
		tasksButton.setTitleColor(.blue, for: .normal)
		tasksButton.setTitleColor(.white, for: .highlighted)
		
		tasksButton.topAnchor.constraint(equalTo: collaboratorsTableView.bottomAnchor, constant: 15).isActive = true
		tasksButton.leadingAnchor.constraint(equalTo: listOfTasksLabel.trailingAnchor, constant: 10).isActive = true
		tasksButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
		tasksButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		// tasksTable
		tasksTableView.topAnchor.constraint(equalTo: listOfCollaboratorsLabel.bottomAnchor, constant: 15).isActive = true
		tasksTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
		tasksTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
		tasksTableView.heightAnchor.constraint(equalToConstant: heightOfCollaboratorsTable).isActive = true
		
		
	}
	
}

//MARK: - Funcs for Buttons
extension ProjectVC {
	
	@objc
	func collaboratorsListOpen() {
		
		heightOfCollaboratorsTable = 100
		
		view.setNeedsLayout()
	}
	
	@objc
	func tasksListOpen() {
		
	}
	
}

extension ProjectVC: UITextViewDelegate {
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
		return newText.count <= 70
	}
	
	// чтобы была ссылка?
	func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
		//и здесь пишете что-то типа такого
		if URL.scheme == "ваше слово" {
			// делаете что надо
			return true
		}
		return false
	}
}
