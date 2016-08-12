//
//  LoginViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-09.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material
import OAuthSwift

class LoginViewController: OAuthViewController {

    var login = ApiController()
    // oauth swift object (retain)
    var oauthswift: OAuthSwift?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = WebViewController()
        controller.view = UIView(frame: UIScreen.mainScreen().bounds) // needed if no nib or not loaded from storyboard
        //controller.delegate = self
        prepareLargeCardViewExample()
    }
    
    
    // Layout View
        
    private func prepareLargeCardViewExample() {
        
        let cardView: MaterialPulseView = MaterialPulseView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        cardView.pulseColor = MaterialColor.blueGrey.base
        cardView.depth = .Depth1
        view.addSubview(cardView)
        
        let contentViewTop: MaterialView = MaterialView()
        contentViewTop.backgroundColor = MaterialColor.blueGrey.darken4
        cardView.addSubview(contentViewTop)
        
        let contentViewbottom: MaterialView = MaterialView()
        contentViewbottom.backgroundColor = MaterialColor.clear
        cardView.addSubview(contentViewbottom)
        

        
        
        let loginWithMeetupButton: UIButton = UIButton()
        loginWithMeetupButton.setTitle("SIGN UP WITH MEETUP", forState: UIControlState.Normal)
        loginWithMeetupButton.setTitleColor(UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100), forState: UIControlState.Normal)
        loginWithMeetupButton.setTitleColor(UIColor.brownColor(), forState: UIControlState.Highlighted)
        loginWithMeetupButton.titleLabel?.font = UIFont(name: "Avenir", size: 15)
        contentViewbottom.addSubview(loginWithMeetupButton)
        loginWithMeetupButton.addTarget(self, action: #selector(handleLoginButton), forControlEvents: .TouchUpInside)
        
        


        contentViewTop.grid.rows = 6
        contentViewTop.grid.columns = 12

        contentViewbottom.grid.rows = 6
        contentViewbottom.grid.columns = 12
        contentViewbottom.grid.offset.rows = 6
        
        cardView.grid.axis.direction = .None
        cardView.grid.spacing = 4
        cardView.grid.views = [
            contentViewTop,
            contentViewbottom
        ]
        
        
        loginWithMeetupButton.grid.rows = 2
        loginWithMeetupButton.grid.columns = 8
        loginWithMeetupButton.grid.offset.rows = 10
        
       
        contentViewbottom.grid.spacing = 2
        contentViewbottom.grid.axis.direction = .None
        contentViewbottom.grid.contentInsetPreset = .Square3
        contentViewbottom.grid.views = [

            loginWithMeetupButton,

        ]
    }
    
    
    // handle login button
    
    internal func handleLoginButton() {
        
        self.presentViewController(login, animated: true) { 
            self.login.doAuthMeetup()
        }
//        login.doAuthMeetup()

    }
    
    

}

//extension LoginViewController: OAuthWebViewControllerDelegate {
//    
//    func oauthWebViewControllerDidPresent() {
//        
//    }
//    func oauthWebViewControllerDidDismiss() {
//        
//    }
//    
//    func oauthWebViewControllerWillAppear() {
//        
//    }
//    func oauthWebViewControllerDidAppear() {
//        
//    }
//    func oauthWebViewControllerWillDisappear() {
//        //        let eventsViewController = EventsViewController()
//        //        let navc: NavigationController = NavigationController(rootViewController: eventsViewController)
//        //        navc.modalTransitionStyle = .CrossDissolve
//        //        presentViewController(navc, animated: true, completion: nil)
//        
//    }
//    func oauthWebViewControllerDidDisappear() {
//        // Ensure all listeners are removed if presented web view close
//        oauthswift?.cancel()
//    }
//}





