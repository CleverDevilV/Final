//
//  JSONParameterEncoderTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 02/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
@testable import GitRepo

/// - Tag: JSONParameterEncoderTests
class JSONParameterEncoderTests: XCTestCase {

	var request: URLRequest!
	var parameters: Parameters!
	var url: URL!
	
	override func setUp() {
		
		url = URL(string: "testJSONEncoder")
		request = URLRequest(url: url)
		parameters = Parameters(dictionaryLiteral: ("Baz", "Bar"))
		do {
			try JSONParameterEncoder.encode(urlRequest: &request, with: parameters)
		} catch {
			print(error)
		}
		
		
	}
	
	override func tearDown() {
		request = nil
		parameters = nil
		url = nil
	}
	
	func testNotNil() {
		// arrange
		// act
		
		// assert
		XCTAssertNotNil(request)
		XCTAssertNotNil(request.url)
	}
	
	func testURLRequestConteinsUrl() {
		// arrange
		// act
		
		// assert
		XCTAssertEqual(request.url, url)
	}
	
	func testURLRequestContainsAtLeastOneHeader() {
		// arrange
		// act
		
		// assert
		XCTAssertEqual(request.allHTTPHeaderFields?.count, 1)
	}
	
	func testURLRequestContainsContentTypeHeader() {
		// arrange
		// act
		
		// assert
		XCTAssertEqual(request.allHTTPHeaderFields?.first?.key, "Content-Type")
		XCTAssertEqual(request.allHTTPHeaderFields?.first?.value, "application/json")
	}
	
	func testEncodingThrowsErrorIfURLIsEqualToNil() {
		// arrange
		request.url = nil
		
		// act
		
		// assert
		XCTAssertThrowsError(try URLParameterEncoder.encode(urlRequest: &request, with: parameters))
		// TODO: выброс ошибки
	}

}
