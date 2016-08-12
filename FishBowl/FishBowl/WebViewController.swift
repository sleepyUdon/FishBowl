//
//  WebViewController.swift
//  FishBowl
//
//  Created by Yevhen Kim on 2016-08-11.
//  Copyright © 2016 Yevhen Kim. All rights reserved.
//

import OAuthSwift

#if os(iOS)
    import UIKit
    typealias WebView = UIWebView // WKWebView
#endif

class WebViewController: OAuthWebViewController, UIWebViewDelegate {
    
    var targetURL : NSURL = NSURL()
    let webView : WebView = WebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if os(iOS)
            self.webView.frame = UIScreen.mainScreen().bounds
            self.webView.scalesPageToFit = true
            self.webView.delegate = self
            self.view.addSubview(self.webView)
            loadAddressURL()
            
        #endif
    }
    
    override func handle(url: NSURL) {
        targetURL = url
        super.handle(url)
        
        loadAddressURL()
    }
    
    func loadAddressURL() {
        let req = NSURLRequest(URL: targetURL)
        self.webView.loadRequest(req)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.URL else {
            return false
        }
        guard url.host == "CardBowlTest" else {
            print(url)
            return false
        }
        self.dismissWebViewController()
        return true
    }
}