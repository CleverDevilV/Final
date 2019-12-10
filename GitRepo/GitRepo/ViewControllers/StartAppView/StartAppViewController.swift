//
//  StartAppViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 30/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

// Unit Tests

protocol LoaderProtocol {
	func getBaseDataFrom(source: SourceType, endPoint: EndPointType?, baseType: BaseType?, completion: @escaping (_ result: Decodable?, _ error: String?) -> ())
}

protocol RootViewControllerProtocol {
	func switchMainScreen()
	func switchToLogout()
}

/// Unit Tests - [StartAppViewControllerTests](x-source-tag://StartAppViewControllerTests)
class StartAppViewController: UIViewController {
	
	//MARK: UI
	private var obiVanImage = UIImageView(image: UIImage(named: "obiVan"))
	private var greetingLabel = UILabel()
	private var userLoginLabel = UILabel()
	private var welcomeButton = UIButton()
	private var logOutButton = UIButton()
	
	private var colorForButtonsTitle: UIColor = UIColor(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1) //#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
	
	private let loadView = DiamondLoad()
	
	//MARK: service VARs
	
	private var login = UserDefaults.standard.get(with: .oauth_user_login)
	private var logOutCommand: LogOutCommand!
	
	private var loader: LoaderProtocol!
	
	//MARK: Presenter
	var presenter: StartViewPresenterProtocol!
	//MARK: RootView
	var rootView: RootViewControllerProtocol!
	
	//MARK: -
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		print("login: ", login)
		
		setupViews()
		
		presenter.setupLoader()
		presenter.setupLogCoutCommand()
		
		downloadData()
	}
	
	func showButtons(){
		UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
			self.welcomeButton.isEnabled = true
			self.logOutButton.isEnabled = true
			self.loadView.layer.opacity = 0
			self.welcomeButton.layer.opacity = 1
			self.logOutButton.layer.opacity = 1
		}, completion: nil)
	}
	
	/// Loading data from Back or CoreData if it's no connection
	private func downloadData() {
		if UserDefaults.standard.isExist(with: .oauth_user_login) {
			
			login = UserDefaults.standard.get(with: .oauth_user_login)
			
			var coreDataService: ManagedObjectFromCoreDataService!
			
			// Load ProjectBase from Back
			loader.getBaseDataFrom(source: .firebase, endPoint: FirebaseApi.getProjects, baseType: nil) {
				result, error in
				
				if error != nil {
					print(error!)
				}
				
				if result == nil {
					// Load ProjectBase From CoreData
					self.loader.getBaseDataFrom(source: .coreData, endPoint: nil, baseType: .projectBase) {
						result,error  in
						
						guard let projectBase = result as? ProjectsBase else {return}
						print(projectBase)
						
						DispatchQueue.main.async {
							
							AppDelegate.shared.projectBase = projectBase
						}
					}
				} else {
					// Save loaded ProjectBase in CoreData
					coreDataService = ManagedObjectFromCoreDataService(withDeleting: true, writeContext: CoreDataStack.shared.writeContext, readContext: CoreDataStack.shared.readContext)
					coreDataService.saveCoreDataObjectsFrom(base: result as? ProjectsBase, baseType: .projectBase)
					
					guard let base = result as? ProjectsBase else {return}
					print(base)
					
					DispatchQueue.main.async {
						AppDelegate.shared.projectBase = base
					}
				}
				
				// Load RepositoryBase From Back
				self.loader.getBaseDataFrom(source: .gitHub, endPoint: GitHubApi.repos, baseType: nil) {
					result, error in
					
					if error != nil {
						print(error!)
					}
					
					if result == nil {
						// Load RepositoryBase From CoreData
						self.loader.getBaseDataFrom(source: .coreData, endPoint: nil, baseType: .repositoryBase) {
							result,error  in
//							print(result)
							
							guard let repositoryBase = result as? RepositoriesBase else {return}
							
							DispatchQueue.main.async {
								print(repositoryBase)
								AppDelegate.shared.repositoryBase = repositoryBase
								self.showButtons()
							}
						}
						
					} else {
						// Save loaded RepositoryBase in CoreData
						coreDataService.saveCoreDataObjectsFrom(base: result as? RepositoriesBase, baseType: .repositoryBase)
						DispatchQueue.main.async {
							AppDelegate.shared.repositoryBase = result as? RepositoriesBase
							self.showButtons()
						}
					}	
				}
			}
		}
	}
	
	func setupViews() {
		
		view.backgroundColor = .white
		navigationController?.setNavigationBarHidden(true, animated: true)
		
		view.addSubview(obiVanImage)
		view.addSubview(greetingLabel)
		view.addSubview(userLoginLabel)
		view.addSubview(welcomeButton)
		view.addSubview(logOutButton)
		
		login = UserDefaults.standard.get(with: .oauth_user_login)
		
		if UserDefaults.standard.isExist(with: .oauth_user_login) {
		
			loadView.dotsColor = UIColor(red: 1, green: 0.6655423641, blue: 0.5648387074, alpha: 1) //#colorLiteral(red: 1, green: 0.6655423641, blue: 0.5648387074, alpha: 1)
			loadView.frame.size = CGSize(width: 70, height: 70)
			loadView.center = CGPoint(x: view.center.x, y: view.center.y + 110)
			loadView.startAnimating()
			view.addSubview(loadView)
			
			welcomeButton.layer.opacity = 0
			logOutButton.layer.opacity = 0
			welcomeButton.isEnabled = true
			logOutButton.isEnabled = true
		}
		
		
		let defWidth = UIScreen.main.bounds.size.width
		
		obiVanImage.translatesAutoresizingMaskIntoConstraints = false
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
			obiVanImage.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 30),
			obiVanImage.centerXAnchor.constraint(greaterThanOrEqualTo: view.centerXAnchor, constant: 0),
			obiVanImage.heightAnchor.constraint(equalTo: obiVanImage.widthAnchor, constant: 0),
			obiVanImage.bottomAnchor.constraint(equalTo: greetingLabel.topAnchor, constant: -15)
		])
		
		NSLayoutConstraint.activate([
			greetingLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 40),
			greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
			greetingLabel.heightAnchor.constraint(equalToConstant: 70),
			greetingLabel.widthAnchor.constraint(equalToConstant: defWidth),
			greetingLabel.bottomAnchor.constraint(equalTo: userLoginLabel.topAnchor, constant: 45)
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
		welcomeButton.setTitleColor(colorForButtonsTitle, for: .normal)
		welcomeButton.backgroundColor = UIColor(red: 1, green: 0.6, blue: 0, alpha: 0.2)
		welcomeButton.layer.borderColor = colorForButtonsTitle.cgColor
		welcomeButton.layer.borderWidth = 1
		welcomeButton.layer.cornerRadius = 20
		welcomeButton.layer.masksToBounds = true
		welcomeButton.addTarget(self, action: #selector(tapWelcomeButton(_:)), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			welcomeButton.topAnchor.constraint(equalTo: userLoginLabel.bottomAnchor, constant: 0),
			welcomeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
			welcomeButton.widthAnchor.constraint(equalToConstant: defWidth / 3),
			welcomeButton.heightAnchor.constraint(equalToConstant: 50)
			])
		
		// logOutButton
		logOutButton.isHidden = login.isEmpty
		logOutButton.setTitle("Выйти", for: .normal)
		logOutButton.setTitleColor(colorForButtonsTitle, for: .normal)
		logOutButton.backgroundColor = #colorLiteral(red: 1, green: 0.7231550813, blue: 0.4947916865, alpha: 1)//UIColor(red: 1, green: 0.6, blue: 0, alpha: 0.4)
		logOutButton.layer.borderColor = colorForButtonsTitle.cgColor
		logOutButton.layer.borderWidth = 1
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
	
	func showAllertIfDisconnect() {
		let allert = UIAlertController(title: "Отсутствует подключение к интернету 😔", message: "Восстановите подключение к сети и перезапустите приложение.", preferredStyle: .alert)
		let okAction =  UIAlertAction(title: "OK", style: .default, handler: nil)
		allert.addAction(okAction)
		present(allert, animated: true, completion: nil)
	}
}

extension StartAppViewController {
	@objc
	func tapWelcomeButton(_ sender: UIButton) {
		
		guard ConnectChecker.isConnectedToNetwork() else {
			print("Internet connection FAILED")
			showAllertIfDisconnect()
			return
		}
		
			UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
				self.obiVanImage.layer.opacity = 0
				self.greetingLabel.layer.opacity = 0
				self.userLoginLabel.layer.opacity = 0
				self.welcomeButton.layer.opacity = 0
				self.logOutButton.layer.opacity = 0
//				self.view.layer.opacity = 0
			}, completion: {
				_ in
				
				if sender.titleLabel?.text == "Войти" {
					let registrationView = RequestViewController()
					registrationView.modalPresentationStyle = .fullScreen
					
					self.present(registrationView, animated: false, completion: nil)
				} else {
//					self.switchRootViewControllerToMainScreen()
					guard NSClassFromString("XCTestCase") == nil else { return }
//					guard AppDelegate.shared != nil else { return }
					AppDelegate.shared.rootViewController.switchMainScreen()
				}
			})
	}
	
	/// Logout User
	@objc
	func tapLogOutButton() {
//		let logOtcommand = LogOutCommand()
//		logOtcommand.logOut()
		logOutCommand.logOut()
//		login = UserDefaults.standard.get(with: .oauth_user_login)
		loadView()
		setupViews()
		
	}
}

//MARK: - StartViewProtocol
extension StartAppViewController: StartViewProtocol {
	
	func setLoader(loader: LoaderProtocol?) {
		self.loader = loader
	}
	
	func setLogoutCommand(command: LogOutCommand?) {
		self.logOutCommand = command
	}
}

//MARK: - ManagedViewControllerByRootViewControllerProtocol
extension StartAppViewController: ManagedViewControllerByRootViewControllerProtocol {
	
	func setupRootViewController(_ rootView: RootViewControllerProtocol) {
		self.rootView = rootView
	}
	
	func switchRootViewControllerToMainScreen() {
		rootView.switchMainScreen()
	}
	
	func switchRootViewControllerToLogoutScreen() {
		rootView.switchToLogout()
	}
}
