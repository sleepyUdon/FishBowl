//
//  WebViewController.swift
//  FishBowl
//
//  Created by Yevhen Kim on 2016-08-11.
//  Copyright © 2016 Yevhen Kim. All rights reserved.
//

import OAuthSwift

import UIKit
typealias WebView = UIWebView // WKWebView


class WebViewController: OAuthWebViewController, UIWebViewDelegate {
    
    var targetURL : URL = URL()
    let webView : WebView = WebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        self.webView.frame = CGRect(x: 0, y: 20, width: width, height: height)
        self.webView.scalesPageToFit = true
        self.webView.delegate = self
        self.view.addSubview(self.webView)
        loadAddressURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //set up delegate once the web view is shown
        self.webView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //incase the web view is still loading its content
        self.webView.stopLoading()
        //disconnect the delegate as the web view is hidden
        self.webView.delegate = nil
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    override func handle(_ url: URL) {
        targetURL = url
        super.handle(url)
        
        loadAddressURL()
    }
    
    func loadAddressURL() {
        let req = URLRequest(url: targetURL)
        self.webView.loadRequest(req)

    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url else {
            return false
        }
        guard url.host == "FishBowlKomrad" else {
            print(url)
            return true
        }
        self.dismissWebViewController()
        return true
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
//    func webViewDidStartLoad(webView: UIWebView) {
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//    }
//    
//    func webViewDidFinishLoad(webView: UIWebView) {
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//    }
//    
//    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//        
//        let errorString = String(format: "<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>", error!.localizedDescription)
//        self.webView.loadHTMLString(errorString, baseURL: nil)
//        
//    }
    
    
}
