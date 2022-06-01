//
//  WebViewController.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 08.05.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView = WKWebView()
    
    override func viewDidLoad() {
        webView.uiDelegate = self
        view = webView
    }
    
    func loadWebPage(_ string: String) {
        guard let url = URL(string: string) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
