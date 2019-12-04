//
//  RepoWebViewController.swift
//  GitRepo
//
//  Created by Дарья Витер on 02/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit
import WebKit

final class SomeUrlWebViewController: UIViewController {
	
	public var url: URL?
	
	private var webView: WKWebView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
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
		
		if let url = navigationAction.request.url {
			if url.absoluteString.contains("https://github.com/") {
				decisionHandler(.allow)
			}
		} else {
			decisionHandler(.cancel)
		}
	}
}
