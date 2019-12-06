//
//  URLParameterEncoderTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 02/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest

/// - Tag: URLParameterEncoderTests

class URLParameterEncoderTests: XCTestCase {
	
	var request: URLRequest!
	var parameters: Parameters!
	var url: URL!

    override func setUp() {
		
		url = URL(string: "testUrlEncoder")
		request = URLRequest(url: url)
		parameters = Parameters(dictionaryLiteral: ("Baz", "Bar"))
		do {
			try URLParameterEncoder.encode(urlRequest: &request, with: parameters)
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
		XCTAssertNotNil(request)
		XCTAssertNotNil(request.url)
	}

	func testURLRequestConteinsUrl() {
		XCTAssertEqual(request.url, url)
	}
	
    func testURLRequestContainsAtLeastOneHeader() {
		XCTAssertEqual(request.allHTTPHeaderFields?.count, 1)
    }
	
	func testURLRequestContainsContentTypeHeader() {
		XCTAssertEqual(request.allHTTPHeaderFields?.first?.key, "Content-Type")
		XCTAssertEqual(request.allHTTPHeaderFields?.first?.value, "application/x-www-form-urlencoded; charset=utf-8")
	}
	
	func testEncodingThrowsErrorIfURLIsEqualToNil() {
		request.url = nil
		XCTAssertThrowsError(try URLParameterEncoder.encode(urlRequest: &request, with: parameters))
	}
}
