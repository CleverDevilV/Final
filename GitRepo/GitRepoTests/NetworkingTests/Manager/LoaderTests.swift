//
//  LoaderTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: LoaderTests
class LoaderTests: XCTestCase {
	
	/// - Tag: MockCoreDataService
	class DummyCoreDataService: CoreDataServiceProtocol {
		func getData(baseType: BaseType, _ completion: @escaping (Decodable?, String?) -> ()) {
			completion("resultFormCoreData", nil)
		}
	}
	
	class DummyGitHubNetworkManager: NetworkManagerProtocol {
		func getData(endPoint: EndPointType, completion: @escaping (Decodable?, String?) -> ()) {
			completion("resultFromGitHub", nil)
		}
	}
	
	class DummyFirebaseNetworkManager: NetworkManagerProtocol {
		func getData(endPoint: EndPointType, completion: @escaping (Decodable?, String?) -> ()) {
			completion("resultFromFirebase", nil)
		}
	}
	
	var loader: LoaderProtocol!
	var githubNetworkManager: NetworkManagerProtocol!
	var firebaseNetworkManager: NetworkManagerProtocol!
	var coreDataServise: CoreDataServiceProtocol!
	

    override func setUp() {
		super.setUp()
		
		githubNetworkManager = DummyGitHubNetworkManager()
		firebaseNetworkManager = DummyFirebaseNetworkManager()
		coreDataServise = DummyCoreDataService()
		
		loader = Loader(githubNetworkManager: githubNetworkManager, firebaseNetworkManager: firebaseNetworkManager, coreDataService: coreDataServise)
    }

    override func tearDown() {
		super.tearDown()
		
		loader = nil
    }
	
	func testLoadFromGitHub() {
		// arrange
		// act
		loader.getBaseDataFrom(source: .gitHub, endPoint: GitHubApi.user, baseType: nil) {
			result, error in
			guard let resultStr: String = result as? String else {return}
			// assert
			XCTAssertEqual(resultStr, "resultFromGitHub")
		}
	}
	
	func testLoadFromGitHubIsNil() {
		// arrange
		// act
		loader.getBaseDataFrom(source: .gitHub, endPoint: nil, baseType: nil) {
			result, error in
			// assert
			XCTAssertNil(result, "result = nil")
		}
	}
	
	func testLoadFromFirebase() {
		// arrange
		// act
		loader.getBaseDataFrom(source: .firebase, endPoint: FirebaseApi.getProjects, baseType: nil) {
			result, error in
			guard let resultStr: String = result as? String else {return}
			// assert
			XCTAssertEqual(resultStr, "resultFromFirebase")
		}
	}
	
	func testLoadFromFirebaseIsNil() {
		// arrange
		// act
		loader.getBaseDataFrom(source: .firebase, endPoint: nil, baseType: nil) {
			result, error in
			// assert
			XCTAssertNil(result, "result = nil")
		}
	}
	
	func testLoadFromCoreData() {
		// arrange
		// act
		loader.getBaseDataFrom(source: .coreData, endPoint: nil, baseType: .projectBase) {
			result, error in
			guard let resultStr: String = result as? String else {return}
			// assert
			XCTAssertEqual(resultStr, "resultFormCoreData")
		}
	}
	
	func testLoadFromCoreDataIsNil() {
		// arrange
		// act
		loader.getBaseDataFrom(source: .coreData, endPoint: nil, baseType: nil) {
			result, error in
			// assert
			XCTAssertNil(result, "result = nil")
		}
	}
	
	
	
	
	

}
