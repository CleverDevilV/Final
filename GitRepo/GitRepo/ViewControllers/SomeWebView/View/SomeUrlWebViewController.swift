//
//  RepoWebViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 02/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit
import WebKit

/**
Class for show pages in WebView. Need to insert URL.
```
public var url: URL?
```
*/
final class SomeUrlWebViewController: UIViewController {
	
	public var presenter: SomeWebPresenterProtocol!
	
	private var url: URL?
	private var webView: WKWebView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		presenter.setURL()
		setupView()
    }
	
	private func setupView() {
		webView = WKWebView(frame: view.frame)
		webView.navigationDelegate = self
		webView.load(request()!)
		
		view.addSubview(webView)
	}
	
	private func request() -> URLRequest? {
		guard let url = url else { return nil }
		var request = URLRequest(url: url)
		
		request.httpMethod = "GET"
		
		return request
	}
	
}

extension SomeUrlWebViewController: WKNavigationDelegate {
	
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		
		guard NSClassFromString("XCTestCase") == nil  else {
				decisionHandler(.cancel)
			return
		}
		
		if let url = navigationAction.request.url {
			if url.absoluteString.contains("https://github.com/") {
				decisionHandler(.allow)
			}
		} else {
			decisionHandler(.cancel)
		}
	}
}

extension SomeUrlWebViewController: SomeWebViewProtocol {
	func setURL(_ url: URL) {
		self.url = url
	}
}
