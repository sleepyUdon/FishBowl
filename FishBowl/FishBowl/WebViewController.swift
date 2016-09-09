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
    
    var targetURL : NSURL = NSURL()
    let webView : WebView = WebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        self.webView.frame = CGRectMake(0, 20, width, height)
        self.webView.scalesPageToFit = true
        self.webView.delegate = self
        self.view.addSubview(self.webView)
        loadAddressURL()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //set up delegate once the web view is shown
        self.webView.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        //incase the web view is still loading its content
        self.webView.stopLoading()
        //disconnect the delegate as the web view is hidden
        self.webView.delegate = nil
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
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
        guard url.host == "FishBowlKomrad" else {
            print(url)
            return true
        }
        self.dismissWebViewController()
        return true
    }
    
    override func shouldAutorotate() -> Bool {
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