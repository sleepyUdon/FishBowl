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

    fileprivate var containerView: UIView!
    // NavigationBar buttons
    fileprivate var menuButton: IconButton!
    fileprivate var profileButton: IconButton!

    
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
    
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if AppDelegate.token == nil {
            prepareLoginView()
        }
    }
    
    // General prepare LoginView
    fileprivate func prepareLoginView() {
        let loginViewController = LoginViewController()
        self.present(loginViewController, animated: true) { 
            //print("login view presented")
        }
    }

    // General preparation statements.
    fileprivate func prepareView() {
        view.backgroundColor = Color.accentColor1
    }
    
    // Prepares the menuButton.
    fileprivate func prepareMenuButton() {
        let image: UIImage? = MaterialIcon.cm.menu
        menuButton = IconButton()
        menuButton.pulseColor = Color.accentColor1
        menuButton.tintColor = Color.accentColor1
        menuButton.setImage(image, for: UIControlState())
        menuButton.setImage(image, for: .highlighted)
        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }

    // Handles the menuButton.
    internal func handleMenuButton() {
        let contactVC: ContactsViewController = ContactsViewController()
        //navigationDrawerController?.openLeftView()
        contactVC.getAllContacts()
        contactVC.didUpdateContacs()
        contactVC.prepareTableView()
        
        self.present(contactVC, animated: true, completion: nil)
    }
    
    // Prepares the profileButton.
    fileprivate func prepareProfileButton() {
        
        let image: UIImage? = MaterialIcon.cm.settings
        profileButton = IconButton()
        profileButton.isEnabled = true
        profileButton.imageEdgeInsets = UIEdgeInsets.zero
        profileButton.pulseColor = Color.accentColor1
        profileButton.tintColor = Color.accentColor1
        profileButton.setImage(image, for: UIControlState())
        profileButton.setImage(image, for: .highlighted)
        profileButton.addTarget(self, action: #selector(handleProfileButton), for: .touchUpInside)
    }
    
    // Handles the profileButton.
    internal func handleProfileButton() {
        let profileViewController = ProfileViewController()
        let navc: NavigationController = NavigationController(rootViewController: profileViewController)
        present(navc, animated: true, completion: nil)
    }
    
    // Prepares the containerView.
    fileprivate func prepareContainerView() {
        containerView = UIView()
        view.layout(containerView).edges(top: 0, left: 0, right: 0)
    }
    
    // Prepares the tableView
    fileprivate func prepareTableView() {
        displayContentController(MenuViewController(), frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
    }
    
    // Prepares the navigationItem.
    fileprivate func prepareNavigationItem() {
        navigationItem.title = "Events"
        navigationItem.titleLabel.textAlignment = .center
        navigationItem.titleLabel.textColor = Color.accentColor1
        navigationItem.titleLabel.font = Fonts.navigationTitle
        
        navigationItem.leftControls = [menuButton]
        navigationItem.rightControls = [profileButton]
    }
    
    /// Prepares the navigationBar.
    fileprivate func prepareNavigationBar() {
        /**
         To control this setting, set the "View controller-based status bar appearance"
         to "NO" in the info.plist.
         */
        navigationController?.navigationBar.statusBarStyle = .lightContent
        navigationController?.navigationBar.backgroundColor = Color.baseColor1

    }
}




