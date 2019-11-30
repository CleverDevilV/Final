//
//  RepoVC.swift
//  GitRepo
//
//  Created by Дарья Витер on 25/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {
	
	public var repo: Repo?
	private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .white
		title = repo?.name
		
		setupViews()
    }
	
	func setupViews() {
		tableView = UITableView(frame: view.frame, style: .plain)
		tableView.backgroundColor = UIColor(red: 1, green: 0.5781051517, blue: 0, alpha: 0.04508240583)
		view.addSubview(tableView)
	}
}
