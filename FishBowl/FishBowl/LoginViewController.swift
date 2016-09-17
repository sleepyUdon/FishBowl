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
    
    let backgroundView: MaterialPulseView = MaterialPulseView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    
    // Layout View
    
    fileprivate func prepareView() {
        let backgroundView: MaterialPulseView = MaterialPulseView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        backgroundView.backgroundColor = MaterialColor.pink.accent2
        view.addSubview(backgroundView)
        
        let fishBowlLabel : UILabel = UILabel()
        fishBowlLabel.frame = CGRect(x: backgroundView.frame.width/2 - 100.0, y: (25.0), width: CGFloat(200.0), height: CGFloat(30.0))
        fishBowlLabel.text = "F I S H B O W L"
        fishBowlLabel.textAlignment = .center
        fishBowlLabel.textColor = MaterialColor.white
        fishBowlLabel.font = Fonts.title
        backgroundView.addSubview(fishBowlLabel)
        

        
        let imageName = "fishbowl"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: backgroundView.frame.width/2 - 50.0, y: backgroundView.frame.height/2 - (50.0), width: CGFloat(100.0), height: CGFloat(100.0))
        backgroundView.addSubview(imageView)
        
        
        let loginWithMeetupButton: MaterialButton = MaterialButton()
        loginWithMeetupButton.pulseColor = MaterialColor.pink.lighten1
        loginWithMeetupButton.setTitle("SIGN UP WITH MEETUP", for: UIControlState())
        loginWithMeetupButton.setTitleColor(MaterialColor.white, for: UIControlState())
        loginWithMeetupButton.setTitleColor(MaterialColor.pink.lighten1, for: UIControlState.highlighted)
        loginWithMeetupButton.titleLabel?.font = Fonts.title
        loginWithMeetupButton.backgroundColor = MaterialColor.pink.lighten1
        
        loginWithMeetupButton.frame = CGRect(x: CGFloat(0.0), y: backgroundView.frame.height - (50.0), width: backgroundView.frame.width, height: (60.0))
        view.addSubview(loginWithMeetupButton)
        loginWithMeetupButton.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        
        
        UIView.animate(withDuration: 3.0, animations: { () -> Void in
            backgroundView.backgroundColor = MaterialColor.purple.accent3
        }, completion: { (Bool) -> Void in
       
                            UIView.animate(withDuration: 3.0, animations: { () -> Void in
                                backgroundView.backgroundColor = MaterialColor.pink.accent2
                                }, completion:nil)
        }) 
    }
    
    internal func handleLoginButton() {
        
        self.present(login, animated: true) {
        }
        self.login.doAuthMeetup()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

    }
    
    
    
}





