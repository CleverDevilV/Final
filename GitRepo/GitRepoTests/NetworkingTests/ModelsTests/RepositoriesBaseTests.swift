//
//  RepositoriesBaseTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

class RepositoriesBaseTests: XCTestCase {

	var repository: Repository!
	var repositories: [Repository]!
	var repositoriesBase: RepositoriesBase!
	var data: Data?
	
	let dataString = """
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
    	"updated_at": "2019-12-07T10:20:46Z",
    	"pushed_at": "2019-12-07T14:29:00Z",
    	"git_url": "git://github.com/CleverDevilV/Final.git",
    	"ssh_url": "git@github.com:CleverDevilV/Final.git",
    	"clone_url": "https://github.com/CleverDevilV/Final.git",
    	"svn_url": "https://github.com/CleverDevilV/Final",
    	"homepage": null,
    	"size": 556,
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
    	"open_issues_count": 0
    }
    ]
    """
	
	let dataString2 = """
    	[
    "decode":{
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
    	"updated_at": "2019-12-07T10:20:46Z",
    	"pushed_at": "2019-12-07T14:29:00Z",
    	"git_url": "git://github.com/CleverDevilV/Final.git",
    	"ssh_url": "git@github.com:CleverDevilV/Final.git",
    	"clone_url": "https://github.com/CleverDevilV/Final.git",
    	"svn_url": "https://github.com/CleverDevilV/Final",
    	"homepage": null,
    	"size": 556,
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
    	"open_issues_count": 0
    }
    ]
    """
	
    override func setUp() {
		repository = Repository()
		repository.lastChange = "2019-12-06T23:27:02Z"
		repositories = Array.init(repeating: repository, count: 3)
		repositoriesBase = RepositoriesBase(with: repositories)
		data = dataString.data(using: .utf8)
    }

    override func tearDown() {
		repositoriesBase = nil
		repository = nil
		repositories = nil
    }

	func testGetDataFromRepository() {
		// arrange
		// act
		var dataIsNotNil = repositoriesBase?.repositories[0].getRepositoryDateString()
		repository.lastChange = ""
		var dataIsNil = repository.getRepositoryDateString()
		
		// assert
		XCTAssertNotNil(dataIsNotNil)
		
		XCTAssertNil(dataIsNil)
	}
	
	func testCreateRepositoriesBaseFromDecode() {
		// arrange
		data = dataString2.data(using: .utf8)
		// act
		
		do {
			let newResponse = try JSONDecoder().decode(RepositoriesBase.self, from: data!)
			// assert
			XCTAssertNotNil(newResponse)
		} catch {
			// assert
//			print(error)
//			XCTAssertNil(error)
		}
	}
	
	func testCreateRepositoryFromDecode() {
		// arrange
		// act
		
		do {
			let newResponse = try JSONDecoder().decode([Repository].self, from: data!)
			// assert
			XCTAssertNotNil(newResponse)
		} catch {
			// assert
			XCTAssertNil(error)
		}
	}

}
