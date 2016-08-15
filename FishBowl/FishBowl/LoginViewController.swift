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

    var login = APIController()
    // oauth swift object (retain)
    var oauthswift: OAuthSwift?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLargeCardViewExample()
    }
    
    
    // Layout View
        
    private func prepareLargeCardViewExample() {
        
        let cardView: MaterialPulseView = MaterialPulseView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        cardView.pulseColor = Color.baseColor1
        cardView.depth = .Depth1
        view.addSubview(cardView)
        
        let contentViewTop: MaterialView = MaterialView()
        contentViewTop.backgroundColor = Color.baseColor1
        cardView.addSubview(contentViewTop)
        
        let contentViewbottom: MaterialView = MaterialView()
        contentViewbottom.backgroundColor = MaterialColor.clear
        cardView.addSubview(contentViewbottom)
        
        let loginWithMeetupButton: UIButton = UIButton()
        loginWithMeetupButton.setTitle("SIGN UP WITH MEETUP", forState: UIControlState.Normal)
        loginWithMeetupButton.setTitleColor(Color.accentColor1, forState: UIControlState.Normal)
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
        
        self.login.doAuthMeetup()

    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)

    }
    
    

}







