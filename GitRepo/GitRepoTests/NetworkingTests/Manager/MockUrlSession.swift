//
//  MockUrlSession.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
	
	private let closure: () -> Void
	
	/// Init with Data Task a closure.
	init(closure: @escaping () -> Void) {
		self.closure = closure
	}
	
	/// When call 'resume' - call init closure
	override func resume() {
		closure()
	}
}

class MockUrlSession: URLSession {
	
	var gitHubEndPoint: GitHubApi!
	var firebaseEndPoint: FirebaseApi!
	
	override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		let dataTask = URLSessionDataTaskMock(closure: {
			
			var data: Data = "data".data(using: .utf8)!
			var error: Error? = nil
			var response: HTTPURLResponse? = HTTPURLResponse(url: URL(string: "Bar")!, statusCode: 200, httpVersion: nil, headerFields: nil)
			
			if self.gitHubEndPoint != nil {
				let strForCheck = request.url?.absoluteString
				
				if strForCheck?.contains("/collaborators") ?? false {
					data = self.collaboratorsData.data(using: .utf8)!
				} else if strForCheck?.contains("/branches") ?? false {
					data = self.branchesData.data(using: .utf8)!
				} else if strForCheck?.contains("/events") ?? false {
					data = self.commintsData.data(using: .utf8)!
				} else {
					data = self.githubData.data(using: .utf8)!
				}
				
				
			} else if self.firebaseEndPoint != nil {
				data = self.firebaseData.data(using: .utf8)!
			} else {
				error = NetworkError.missingURL
				response = nil
			}
			
			completionHandler(data, response, error)
		})
		return dataTask
	}
	
	var githubData = """
[
{
        "id": 223923243,
        "name": "Final",
        "owner": {
            "login": "CleverDevilV"
        },
        "html_url": "https://github.com/CleverDevilV/Final",
        "url": "https://api.github.com/repos/CleverDevilV/Final",
        "collaborators_url": "https://api.github.com/repos/CleverDevilV/Final/collaborators{/collaborator}",
        "events_url": "https://api.github.com/repos/CleverDevilV/Final/events",
        "branches_url": "https://api.github.com/repos/CleverDevilV/Final/branches{/branch}",

        "languages_url": "https://api.github.com/repos/CleverDevilV/Final/languages",

        "commits_url": "https://api.github.com/repos/CleverDevilV/Final/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/CleverDevilV/Final/git/commits{/sha}",

        "created_at": "2019-11-25T10:36:30Z",
        "updated_at": "2019-12-08T19:52:58Z",
        "pushed_at": "2019-12-10T13:05:16Z",

        "language": "Swift"
    },
	{
        "id": 223923244,
        "name": "Test",
        "owner": {
            "login": "CleverDevilV"
        },
        "html_url": "https://github.com/CleverDevilV/Test",
        "url": "https://api.github.com/repos/CleverDevilV/Test",
        "collaborators_url": "https://api.github.com/repos/CleverDevilV/Test/collaborators{/collaborator}",
        "events_url": "https://api.github.com/repos/CleverDevilV/Test/events",
        "branches_url": "https://api.github.com/repos/CleverDevilV/Test/branches{/branch}",

        "languages_url": "https://api.github.com/repos/CleverDevilV/Test/languages",

        "commits_url": "https://api.github.com/repos/CleverDevilV/Test/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/CleverDevilV/Test/git/commits{/sha}",

        "created_at": "2019-11-25T10:36:30Z",
        "updated_at": "2019-12-08T19:52:58Z",
        "pushed_at": "2019-12-10T13:05:16Z",

        "language": "Swift"
    }
]
"""
	
	var collaboratorsData = """
[
    {
        "login": "CleverDevilV",
    }
]
"""
	
	var commintsData = """
[
{
        "id": "11054228971",
        "type": "PushEvent",
        "actor": {
            "id": 53571360,
            "login": "CleverDevilV"
        },
        "payload": {
            "commits": [
                {
                    "sha": "cb73aba905d5e7411fc043a3aece4424dd5fc0b8",
                    "author": {
                        "email": "ViterDA@icloud.com",
                        "name": "Viter"
                    },
                    "message": " Create unit tests for RepoViewControllerTests (cells) and add cell tests to ProjectViewControllerTests",
                    "distinct": true,
                    "url": "https://api.github.com/repos/CleverDevilV/Final/commits/cb73aba905d5e7411fc043a3aece4424dd5fc0b8"
                }
            ]
        },

        "created_at": "2019-12-10T13:05:17Z"
    },
{
        "id": "11054228972",
        "type": "PushEvent",
        "actor": {
            "id": 53571360,
            "login": "CleverDevilV"
        },
        "payload": {
            "commits": [
                {
                    "sha": "cb73aba905d5e7411fc043a3aece4424dd5fc0b8",
                    "author": {
                        "email": "ViterDA@icloud.com",
                        "name": "Viter"
                    },
                    "message": " Create unit tests for RepoViewControllerTests (cells) and add cell tests to ProjectViewControllerTests",
                    "distinct": true,
                    "url": "https://api.github.com/repos/CleverDevilV/Final/commits/cb73aba905d5e7411fc043a3aece4424dd5fc0b8"
                }
            ]
        },

        "created_at": "2019-12-10T13:20:17Z"
    }
]
"""
	
	var branchesData = """
[
    {
        "name": "dev",
        "commit": {
            "sha": "cb73aba905d5e7411fc043a3aece4424dd5fc0b8",
            "url": "https://api.github.com/repos/CleverDevilV/Final/commits/cb73aba905d5e7411fc043a3aece4424dd5fc0b8"
        },
        "protected": false
    }
]
"""
	
	var firebaseData = """
{
    "CleverDevilV": [
        {
            "descriptionOfProject": "Кот",
            "languageOfProject": "Swift",
            "name": "мой проект",
            "projectTasks": [
                "1"
            ],
            "repoUrl": "https://github.com/CleverDevilV/Final",
            "repositoryName": "Final"
        },
        {
            "name": "1"
        }
    ]
}
"""
	
}

