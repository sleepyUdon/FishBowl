//
//  WebViewController.swift
//  FishBowl
//
//  Created by Yevhen Kim on 2016-08-11.
//  Copyright © 2016 Yevhen Kim. All rights reserved.
//

import OAuthSwift
import SystemConfiguration
import ReachabilitySwift

import UIKit
typealias WebView = UIWebView // WKWebView


class WebViewController: OAuthWebViewController, UIWebViewDelegate {
    
    var targetURL : NSURL = NSURL()
    let webView : WebView = WebView()
    var coverView: UIView = UIView()
    
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
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        if hasConnection() == false {
            dispatch_async(dispatch_get_main_queue()) {
                let alert = UIAlertController(title:"No internet connection",
                                              message: "Please connect to internet",
                                              preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion:{
                    let contactVC = ContactsViewController()
                    self.presentViewController(contactVC, animated: true, completion: nil)
                })
            }
        }
    }
    
    func hasConnection() -> Bool {
        do {
            let reachability: Reachability = try Reachability.reachabilityForInternetConnection()
            switch reachability.currentReachabilityStatus{
            case .ReachableViaWiFi:
                print("Connected With wifi")
                return true
            case .ReachableViaWWAN:
                print("Connected With Cellular network(3G/4G)")
                return true
            case .NotReachable:
                print("Not Connected")
                return false
            }
        } catch let error as NSError{
            print(error.debugDescription)
            return false
        }
    }
}
