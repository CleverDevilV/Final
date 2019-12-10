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
        "node_id": "MDEwOlJlcG9zaXRvcnkyMjM5MjMyNDM=",
        "name": "Final",
        "full_name": "CleverDevilV/Final",
        "private": false,
        "owner": {
            "login": "CleverDevilV",
            "id": 53571360,
            "node_id": "MDQ6VXNlcjUzNTcxMzYw",
            "avatar_url": "https://avatars2.githubusercontent.com/u/53571360?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/CleverDevilV",
            "html_url": "https://github.com/CleverDevilV",
            "followers_url": "https://api.github.com/users/CleverDevilV/followers",
            "following_url": "https://api.github.com/users/CleverDevilV/following{/other_user}",
            "gists_url": "https://api.github.com/users/CleverDevilV/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/CleverDevilV/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/CleverDevilV/subscriptions",
            "organizations_url": "https://api.github.com/users/CleverDevilV/orgs",
            "repos_url": "https://api.github.com/users/CleverDevilV/repos",
            "events_url": "https://api.github.com/users/CleverDevilV/events{/privacy}",
            "received_events_url": "https://api.github.com/users/CleverDevilV/received_events",
            "type": "User",
            "site_admin": false
        },
        "html_url": "https://github.com/CleverDevilV/Final",
        "description": null,
        "fork": false,
        "url": "https://api.github.com/repos/CleverDevilV/Final",
        "forks_url": "https://api.github.com/repos/CleverDevilV/Final/forks",
        "keys_url": "https://api.github.com/repos/CleverDevilV/Final/keys{/key_id}",
        "collaborators_url": "https://api.github.com/repos/CleverDevilV/Final/collaborators{/collaborator}",
        "teams_url": "https://api.github.com/repos/CleverDevilV/Final/teams",
        "hooks_url": "https://api.github.com/repos/CleverDevilV/Final/hooks",
        "issue_events_url": "https://api.github.com/repos/CleverDevilV/Final/issues/events{/number}",
        "events_url": "https://api.github.com/repos/CleverDevilV/Final/events",
        "assignees_url": "https://api.github.com/repos/CleverDevilV/Final/assignees{/user}",
        "branches_url": "https://api.github.com/repos/CleverDevilV/Final/branches{/branch}",
        "tags_url": "https://api.github.com/repos/CleverDevilV/Final/tags",
        "blobs_url": "https://api.github.com/repos/CleverDevilV/Final/git/blobs{/sha}",
        "git_tags_url": "https://api.github.com/repos/CleverDevilV/Final/git/tags{/sha}",
        "git_refs_url": "https://api.github.com/repos/CleverDevilV/Final/git/refs{/sha}",
        "trees_url": "https://api.github.com/repos/CleverDevilV/Final/git/trees{/sha}",
        "statuses_url": "https://api.github.com/repos/CleverDevilV/Final/statuses/{sha}",
        "languages_url": "https://api.github.com/repos/CleverDevilV/Final/languages",
        "stargazers_url": "https://api.github.com/repos/CleverDevilV/Final/stargazers",
        "contributors_url": "https://api.github.com/repos/CleverDevilV/Final/contributors",
        "subscribers_url": "https://api.github.com/repos/CleverDevilV/Final/subscribers",
        "subscription_url": "https://api.github.com/repos/CleverDevilV/Final/subscription",
        "commits_url": "https://api.github.com/repos/CleverDevilV/Final/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/CleverDevilV/Final/git/commits{/sha}",
        "comments_url": "https://api.github.com/repos/CleverDevilV/Final/comments{/number}",
        "issue_comment_url": "https://api.github.com/repos/CleverDevilV/Final/issues/comments{/number}",
        "contents_url": "https://api.github.com/repos/CleverDevilV/Final/contents/{+path}",
        "compare_url": "https://api.github.com/repos/CleverDevilV/Final/compare/{base}...{head}",
        "merges_url": "https://api.github.com/repos/CleverDevilV/Final/merges",
        "archive_url": "https://api.github.com/repos/CleverDevilV/Final/{archive_format}{/ref}",
        "downloads_url": "https://api.github.com/repos/CleverDevilV/Final/downloads",
        "issues_url": "https://api.github.com/repos/CleverDevilV/Final/issues{/number}",
        "pulls_url": "https://api.github.com/repos/CleverDevilV/Final/pulls{/number}",
        "milestones_url": "https://api.github.com/repos/CleverDevilV/Final/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/CleverDevilV/Final/notifications{?since,all,participating}",
        "labels_url": "https://api.github.com/repos/CleverDevilV/Final/labels{/name}",
        "releases_url": "https://api.github.com/repos/CleverDevilV/Final/releases{/id}",
        "deployments_url": "https://api.github.com/repos/CleverDevilV/Final/deployments",
        "created_at": "2019-11-25T10:36:30Z",
        "updated_at": "2019-12-08T19:52:58Z",
        "pushed_at": "2019-12-10T13:05:16Z",
        "git_url": "git://github.com/CleverDevilV/Final.git",
        "ssh_url": "git@github.com:CleverDevilV/Final.git",
        "clone_url": "https://github.com/CleverDevilV/Final.git",
        "svn_url": "https://github.com/CleverDevilV/Final",
        "homepage": null,
        "size": 905,
        "stargazers_count": 0,
        "watchers_count": 0,
        "language": "Swift",
        "has_issues": true,
        "has_projects": true,
        "has_downloads": true,
        "has_wiki": true,
        "has_pages": false,
        "forks_count": 0,
        "mirror_url": null,
        "archived": false,
        "disabled": false,
        "open_issues_count": 0,
        "license": {
            "key": "mit",
            "name": "MIT License",
            "spdx_id": "MIT",
            "url": "https://api.github.com/licenses/mit",
            "node_id": "MDc6TGljZW5zZTEz"
        },
        "forks": 0,
        "open_issues": 0,
        "watchers": 0,
        "default_branch": "master",
        "permissions": {
            "admin": true,
            "push": true,
            "pull": true
        }
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
            "login": "CleverDevilV",
            "display_login": "CleverDevilV",
            "gravatar_id": "",
            "url": "https://api.github.com/users/CleverDevilV",
            "avatar_url": "https://avatars.githubusercontent.com/u/53571360?"
        },
        "repo": {
            "id": 223923243,
            "name": "CleverDevilV/Final",
            "url": "https://api.github.com/repos/CleverDevilV/Final"
        },
        "payload": {
            "push_id": 4378377669,
            "size": 1,
            "distinct_size": 1,
            "ref": "refs/heads/dev",
            "head": "cb73aba905d5e7411fc043a3aece4424dd5fc0b8",
            "before": "f34fdace97215d0c0c3d8830baf2071d31717cf9",
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
        "public": true,
        "created_at": "2019-12-10T13:05:17Z"
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

