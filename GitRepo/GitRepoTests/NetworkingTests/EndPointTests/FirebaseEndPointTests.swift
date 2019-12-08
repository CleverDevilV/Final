//
//  FirebaseEndPointTests.swift
//  GitRepo
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: FirebaseEndPointTests

class MockUserDefaults: UserDefaults {
	
}

class FirebaseEndPointTests: XCTestCase {

	var endPoint: FirebaseApi?
	var userDefaults: MockUserDefaults!
	
	override func setUp() {
		userDefaults = MockUserDefaults()
	}
	
	override func tearDown() {
		endPoint = nil
		userDefaults = nil
	}
	
	func testFirebaseApiHttpMethoGET() {
		
		// arrange
		// act
		endPoint = FirebaseApi.getProjects
		// assert
		XCTAssertEqual(endPoint?.httpMethod.rawValue, "GET")
	}
	
	func testFirebaseApiHttpMethoPUT() {
		
		// arrange
		// act
		endPoint = FirebaseApi.uploadProjects(data: nil)
		// assert
		XCTAssertEqual(endPoint?.httpMethod.rawValue, "PUT")
	}
	
	func testFirebaseApiTaskiIsNil() {
		// arrange
		// act
		endPoint = FirebaseApi.getProjects
		// assert
		XCTAssertNotNil(endPoint?.task)
	}
	
	func testFirebaseApiHTTPHeaders() {
		// arrange
		// act
		endPoint = FirebaseApi.getProjects
		// assert
		//???
	}
	
	func testFirebaseApiBaseUrl() {
		
		// arrange]
		endPoint = FirebaseApi.getProjects
		// act
		
		let apiKey = UserDefaults.standard.get(with: UserDefaultsType.firebase_apiKey)
		// assert
		XCTAssertEqual(endPoint?.baseURL, URL(string: "https://final-project-sb.firebaseio.com/projects.json?avvrdd_token=\(apiKey)"))
	}
	
	func testFirebaseApiGetProjectFields() {
		
		// arrange
		endPoint = FirebaseApi.getProjects
		// act
//		let apiKey = UserDefaults.standard.get(with: .firebase_apiKey)
		// assert
		XCTAssertEqual(endPoint?.path, "")
	}
	
	func testFirebaseApiUploadProjectsFields() {
		
		// arrange
		endPoint = FirebaseApi.uploadProjects(data: nil)
		// act
		// assert
		XCTAssertEqual(endPoint?.path, "")
	}
	
	func testGitHubApiOneProjectFields() {
		
		// arrange
		endPoint = FirebaseApi.oneProject(url: nil)
		// act
		
		// assert
		XCTAssertEqual(endPoint?.path, "")
	}
	
	

}
