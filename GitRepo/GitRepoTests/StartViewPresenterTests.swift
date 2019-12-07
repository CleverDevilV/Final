//
//  StartViewPresenterTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest

import XCTest
@testable import GitRepo

class MockLoader: LoaderProtocol {
	var coreDataService: CoreDataServiceProtocol!
	
	func getBaseDataFrom(source: SourceType?, endPoint: EndPointType?, completion: @escaping (Decodable?, String?) -> ()) {
		completion("result", nil)
	}
}

class MockView: StartViewProtocol {
	var loader: LoaderProtocol?
	func setLoader(loader: LoaderProtocol?) {
		self.loader = loader
	}
	
	
}

class StartViewPresenterTests: XCTestCase {
	
	var view: MockView!
	var loader: MockLoader!
	var presenter: StartViewPresenterProtocol!
	
	override func setUp() {
		view = MockView()
		loader = MockLoader()
		presenter = StartViewPresenter(view: view, loader: loader)
	}
	
	override func tearDown() {
		view = nil
		loader = nil
		presenter = nil
	}
	
	func testModuleIsNotNill() {
		XCTAssertNotNil(view, "view is not nil")
	}
	
	func testView() {
		presenter.setupLoader()
		view.loader?.getBaseDataFrom(source: nil, endPoint: nil) {
			result, error in
			guard let resultStr: String = result as? String else {return}
			XCTAssertEqual(resultStr, "result")
		}
	}
}
