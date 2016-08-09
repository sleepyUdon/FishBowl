//
//  LoginViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-09.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material

class LoginViewController: UIViewController {

//    private var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLargeCardViewExample()

    }
    
    
    // Layout View
        
    private func prepareLargeCardViewExample() {
//        _: UIImage? = UIImage(named: "CosmicMindInverted")
        
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
        
        let loginTitleLabel: UILabel = UILabel()
        loginTitleLabel.text = "LOGIN"
        loginTitleLabel.textColor = MaterialColor.blueGrey.darken4
        loginTitleLabel.backgroundColor = MaterialColor.clear
        contentViewbottom.addSubview(loginTitleLabel)
        
        let smallLoginTitleLabel: UILabel = UILabel()
        smallLoginTitleLabel.numberOfLines = 0
        smallLoginTitleLabel.lineBreakMode = .ByTruncatingTail
        smallLoginTitleLabel.font = UIFont(name: "Avenir", size: 15)
        smallLoginTitleLabel.text = "LOGIN"
        smallLoginTitleLabel.textColor = MaterialColor.blueGrey.darken4
        smallLoginTitleLabel.backgroundColor = MaterialColor.clear
        contentViewbottom.addSubview(smallLoginTitleLabel)
        
        
        let loginButton: UIButton = UIButton()
        loginButton.setTitle("LOGIN", forState:UIControlState.Normal)
        loginButton.setTitleColor(UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100), forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColor.brownColor(), forState: UIControlState.Highlighted)
        loginButton.titleLabel?.font = UIFont(name: "Avenir", size: 15)
        contentViewbottom.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(handleLoginButton), forControlEvents: .TouchUpInside)


        let registerLabel: UILabel = UILabel()
        registerLabel.font = UIFont(name: "Avenir", size: 15)
        registerLabel.text = "REGISTER"
        registerLabel.textColor = UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100)
        registerLabel.backgroundColor = MaterialColor.clear
        contentViewbottom.addSubview(registerLabel)
        
        let usernameTextField: UITextField = UITextField()
        usernameTextField.font = UIFont(name: "Avenir", size: 15)
        usernameTextField.placeholder = "username"
        usernameTextField.textAlignment = NSTextAlignment.Center
        usernameTextField.textColor = MaterialColor.black
        usernameTextField.tintColor = MaterialColor.white
        usernameTextField.backgroundColor = UIColor(red: 200/255, green: 215/255, blue: 212/255, alpha: 100)
        contentViewbottom.addSubview(usernameTextField)

        let passwordTextField: UITextField = UITextField()
        passwordTextField.font = UIFont(name: "Avenir", size: 15)
        passwordTextField.placeholder = "*******"
        passwordTextField.textAlignment = NSTextAlignment.Center
        passwordTextField.textColor = MaterialColor.black
        passwordTextField.tintColor = MaterialColor.white
        passwordTextField.backgroundColor = UIColor(red: 200/255, green: 215/255, blue: 212/255, alpha: 100)
        contentViewbottom.addSubview(passwordTextField)

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
        
        loginTitleLabel.grid.rows = 2
        loginTitleLabel.grid.columns = 8
        
        smallLoginTitleLabel.grid.rows = 1
        smallLoginTitleLabel.grid.columns = 5
        smallLoginTitleLabel.grid.offset.rows = 3
        
        registerLabel.grid.rows = 2
        registerLabel.grid.columns = 8
        registerLabel.grid.offset.rows = 10
        
        usernameTextField.grid.rows = 1
        usernameTextField.grid.columns = 7
        usernameTextField.grid.offset.rows = 3
        usernameTextField.grid.offset.columns = 4

        passwordTextField.grid.rows = 1
        passwordTextField.grid.columns = 7
        passwordTextField.grid.offset.rows = 5
        passwordTextField.grid.offset.columns = 4

        loginButton.grid.rows = 1
        loginButton.grid.columns = 4
        loginButton.grid.offset.rows = 7
        loginButton.grid.offset.columns = 7

        contentViewbottom.grid.spacing = 2
        contentViewbottom.grid.axis.direction = .None
        contentViewbottom.grid.contentInsetPreset = .Square3
        contentViewbottom.grid.views = [
            loginTitleLabel,
            registerLabel,
            smallLoginTitleLabel,
            usernameTextField,
            passwordTextField,
            loginButton
//            alarmLabel,
//            alarmButton
        ]
    }
    
    internal func handleLoginButton() {
        let eventsViewController = EventsViewController()
        let navc: NavigationController = NavigationController(rootViewController: eventsViewController)
        navc.modalTransitionStyle = .CrossDissolve
        presentViewController(navc, animated: true, completion: nil)
    }

}





