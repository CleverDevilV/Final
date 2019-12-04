//
//  StartAppViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class StartAppViewController: UIViewController {
	
	private var greetingLabel = UILabel()
	private var userLoginLabel = UILabel()
	
	private var welcomeButton = UIButton()
	private var logOutButton = UIButton()
	
	private let loadView = DiamondLoad()
	
	private var login = UserDefaults.standard.get(with: .oauth_user_login)

    override func viewDidLoad() {
        super.viewDidLoad()
		
		print("login: ", login)
		
		setupViews()
		
		let networkManagerForFirebase = FirebaseNetworkManager()
		networkManagerForFirebase.getData(endPoint: FirebaseApi.getProjects){
			result, error in
			if error != nil {
				print(error!)
			}
			DispatchQueue.main.async {
				AppDelegate.shared.projectBase = result as? ProjectsBase
			}
			
			let networlManagerForGitHub = GitHubNetworkManager()
			networlManagerForGitHub.getData(endPoint: GitHubApi.repos) {
				result, error in
				if error != nil {
					print(error!)
				}
				
				DispatchQueue.main.async {
					AppDelegate.shared.repositoryBase = result as? RepositoriesBase
					UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
						self.loadView.layer.opacity = 0
					}, completion: nil)
				}
			}
			
		}
		
		
    }
	
	func setupViews() {
		
		view.backgroundColor = .white
		
		view.addSubview(greetingLabel)
		view.addSubview(userLoginLabel)
		view.addSubview(welcomeButton)
		view.addSubview(logOutButton)
		
		loadView.dotsColor = UIColor(red: 227 / 255, green: 172 / 255, blue: 1, alpha: 1)
		loadView.frame.size = CGSize(width: 70, height: 70)
		loadView.center = CGPoint(x: view.center.x, y: view.center.y + 150)
		loadView.startAnimating()
		view.addSubview(loadView)
		
		
		let defWidth = UIScreen.main.bounds.size.width
		
		greetingLabel.translatesAutoresizingMaskIntoConstraints = false
		userLoginLabel.translatesAutoresizingMaskIntoConstraints = false
		welcomeButton.translatesAutoresizingMaskIntoConstraints = false
		logOutButton.translatesAutoresizingMaskIntoConstraints = false
		
	// greetingLabel
		let greetingLabelTitle = (login.isEmpty) ? "Привет" : "Привет,"
		greetingLabel.text = greetingLabelTitle
		greetingLabel.font = UIFont.systemFont(ofSize: 20)
		greetingLabel.textAlignment = .center
		
		NSLayoutConstraint.activate([
			greetingLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 50),
			greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
			greetingLabel.heightAnchor.constraint(equalToConstant: 70),
			greetingLabel.widthAnchor.constraint(equalToConstant: defWidth),
			greetingLabel.bottomAnchor.constraint(equalTo: userLoginLabel.topAnchor, constant: 25)
			])
		
	// userLoginLabel
		let userLoginLabelTitle = (login.isEmpty) ? "" : login
		userLoginLabel.text = userLoginLabelTitle
		userLoginLabel.font = UIFont.systemFont(ofSize: 24)
		userLoginLabel.textAlignment = .center
		
		NSLayoutConstraint.activate([
			userLoginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
			userLoginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
			userLoginLabel.heightAnchor.constraint(equalToConstant: 100),
			userLoginLabel.widthAnchor.constraint(equalToConstant: defWidth)
		])
		
	// welcomeButton
		let welcomeButtonTitle = (login.isEmpty) ? "Войти" : "Продолжить"
		welcomeButton.setTitle(welcomeButtonTitle, for: .normal)
		welcomeButton.setTitleColor(UIColor(red: 1, green: 0.6, blue: 0, alpha: 0.6), for: .normal)
		welcomeButton.backgroundColor = UIColor(red: 1, green: 0.6, blue: 0, alpha: 0.2)
		welcomeButton.layer.cornerRadius = 20
		welcomeButton.layer.masksToBounds = true
		welcomeButton.addTarget(self, action: #selector(tapWelcomeButton(_:)), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			welcomeButton.topAnchor.constraint(equalTo: userLoginLabel.bottomAnchor, constant: 0),
			welcomeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
			welcomeButton.widthAnchor.constraint(equalToConstant: defWidth / 3),
			welcomeButton.heightAnchor.constraint(equalToConstant: 50),
//			welcomeButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -50)
			])
		
	// logOutButton
		logOutButton.isHidden = login.isEmpty
		logOutButton.setTitle("Выйти", for: .normal)
		logOutButton.setTitleColor(UIColor(red: 1, green: 0.6, blue: 0, alpha: 0.8), for: .normal)
		logOutButton.backgroundColor = UIColor(red: 1, green: 0.6, blue: 0, alpha: 0.4)
		logOutButton.layer.cornerRadius = 20
		logOutButton.layer.masksToBounds = true
		logOutButton.addTarget(self, action: #selector(tapLogOutButton), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			logOutButton.topAnchor.constraint(equalTo: welcomeButton.bottomAnchor, constant: 20),
			logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
			logOutButton.widthAnchor.constraint(equalToConstant: defWidth / 3),
			logOutButton.heightAnchor.constraint(equalToConstant: 50),
			logOutButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -50)
			])
	}
}

extension StartAppViewController {
	@objc
	func tapWelcomeButton(_ sender: UIButton) {
		if sender.titleLabel?.text == "Войти" {
			UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
				self.greetingLabel.layer.opacity = 1
				self.userLoginLabel.layer.opacity = 1
				self.welcomeButton.layer.opacity = 0
				self.view.layer.opacity = 1
			}, completion: {
				_ in
				self.present(RequestViewController(), animated: false, completion: nil)
			})
		} else {
			UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
				self.greetingLabel.layer.opacity = 1
				self.userLoginLabel.layer.opacity = 1
				self.welcomeButton.layer.opacity = 0
				self.view.layer.opacity = 1
			}, completion: {
				_ in
				AppDelegate.shared.rootViewController.switchMainScreen()
			})
		}
	}
	
	@objc
	func tapLogOutButton() {
		let logOtcommand = LogOutCommand()
		logOtcommand.logOut()
		login = UserDefaults.standard.get(with: .oauth_user_login)
		loadView()
		setupViews()
	}
}
