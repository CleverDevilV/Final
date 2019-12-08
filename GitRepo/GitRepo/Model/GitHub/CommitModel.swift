//
//  CommitModel.swift
//  GitRepo
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

// Unit tests

struct Commits: Codable {
	let size: Int?
	let commits: [Commit]?
}

/**
Model For [Commit](x-source-tag://Commit).
Tests - [CommitModelTests](x-source-tag://CommitModelTests).
*/
/// - Tag: Commit
struct Commit: Codable {
	let sha: String?
	let message: String?
	let author: Author?
	let url: String?
	var date: String?
	private var html_url: String?
	
	init(sha: String?, message: String?, author: Author?, url: String?, date: String?) {
		self.sha = sha
		self.message = message
		self.author = author
		self.url = url
		self.date = date
	}
	
	struct Author: Codable {
		let name: String
		let email: String?
		let date: String?
	}
	
	/// Function for get url of commit from api for show in WebView
	mutating func getUrlOfCommit() -> String? {
		if self.html_url == nil {
			self.html_url = self.url?.replacingOccurrences(of: "https://api.", with: "https://").replacingOccurrences(of: "repos/", with: "").replacingOccurrences(of: "commits", with: "commit")
		}
		return self.html_url
	}
	
	/**
	Function for get date string
	- Returns: String with date format "yyyy-MM-dd' 'HH:mm:ss", time zone MSK
	*/
	func getCommitDateString() -> String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		dateFormatter.timeZone = TimeZone(abbreviation: "MSK")
		guard let date = dateFormatter.date(from: self.date ?? "") else { return nil }
		dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
		return dateFormatter.string(from: date)
	}
}
