//
//  SomeUrlWebViewControllerTests.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 09/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import XCTest
import WebKit
@testable import GitRepo

/// - Tag: SomeUrlWebViewControllerTests
class SomeUrlWebViewControllerTests: XCTestCase {
	
	class SpyWebView: WKWebView {
		var log: String?
		override func load(_ request: URLRequest) -> WKNavigation? {
			log = request.url?.absoluteString
			return nil
		}
	}
	
	var testView: SomeUrlWebViewController!

    override func setUp() {
		super.setUp()
		
		testView = SomeUrlWebViewController()
    }

    override func tearDown() {
		super.tearDown()
		
		testView = nil
    }
	
	func testNavigationAction () {
		// arrange
		let spyWebView = SpyWebView()
		let navig = WKNavigationAction()
		let decision = WKNavigationActionPolicy.cancel
		// act
		testView.webView(spyWebView, decidePolicyFor: navig) {
			testedDecision in
			
			// assert
			XCTAssertEqual(testedDecision, decision)
		}
	}
	
}
