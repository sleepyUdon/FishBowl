//  EventsViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io . All rights reserved.

import UIKit
import Material
import OAuthSwift

class EventsViewController: UIViewController, UISearchBarDelegate {

    private var containerView: UIView!
    // NavigationBar buttons
    private var menuButton: IconButton!
    private var profileButton: IconButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareMenuButton()
        prepareProfileButton()
        prepareContainerView()
        prepareTableView()
        prepareNavigationItem()
        prepareNavigationBar()
    }
    
        
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if AppDelegate.token == nil {
            prepareLoginView()
        }
    }
    
    // General prepare LoginView
    private func prepareLoginView() {
        let loginViewController = LoginViewController()
        self.presentViewController(loginViewController, animated: true) { 
            //print("login view presented")
        }
    }

    // General preparation statements.
    private func prepareView() {
        view.backgroundColor = Color.accentColor1
    }
    
    // Prepares the menuButton.
    private func prepareMenuButton() {
        let image: UIImage? = MaterialIcon.cm.menu
        menuButton = IconButton()
        menuButton.pulseColor = Color.accentColor1
        menuButton.tintColor = Color.accentColor1
        menuButton.setImage(image, forState: .Normal)
        menuButton.setImage(image, forState: .Highlighted)
        menuButton.addTarget(self, action: #selector(handleMenuButton), forControlEvents: .TouchUpInside)
    }

    // Handles the menuButton.
    internal func handleMenuButton() {
        let contactVC: ContactsViewController = ContactsViewController()
        //navigationDrawerController?.openLeftView()
        contactVC.getAllContacts()
        contactVC.didUpdateContacs()
        contactVC.prepareTableView()
        
        self.presentViewController(contactVC, animated: true, completion: nil)
    }
    
    // Prepares the profileButton.
    private func prepareProfileButton() {
        
        let image: UIImage? = MaterialIcon.cm.settings
        profileButton = IconButton()
        profileButton.enabled = true
        profileButton.imageEdgeInsets = UIEdgeInsetsZero
        profileButton.pulseColor = Color.accentColor1
        profileButton.tintColor = Color.accentColor1
        profileButton.setImage(image, forState: .Normal)
        profileButton.setImage(image, forState: .Highlighted)
        profileButton.addTarget(self, action: #selector(handleProfileButton), forControlEvents: .TouchUpInside)
    }
    
    // Handles the profileButton.
    internal func handleProfileButton() {
        let profileViewController = ProfileViewController()
        let navc: NavigationController = NavigationController(rootViewController: profileViewController)
        presentViewController(navc, animated: true, completion: nil)
    }
    
    // Prepares the containerView.
    private func prepareContainerView() {
        containerView = UIView()
        view.layout(containerView).edges(top: 0, left: 0, right: 0)
    }
    
    // Prepares the tableView
    private func prepareTableView() {
        displayContentController(MenuViewController(), frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
    }
    
    // Prepares the navigationItem.
    private func prepareNavigationItem() {
        navigationItem.title = "Events"
        navigationItem.titleLabel.textAlignment = .Center
        navigationItem.titleLabel.textColor = Color.accentColor1
        navigationItem.titleLabel.font = Fonts.navigationTitle
        
        navigationItem.leftControls = [menuButton]
        navigationItem.rightControls = [profileButton]
    }
    
    /// Prepares the navigationBar.
    private func prepareNavigationBar() {
        /**
         To control this setting, set the "View controller-based status bar appearance"
         to "NO" in the info.plist.
         */
        navigationController?.navigationBar.statusBarStyle = .LightContent
        navigationController?.navigationBar.backgroundColor = Color.baseColor1

    }
}




