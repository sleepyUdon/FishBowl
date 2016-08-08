//
//  EventsViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material

class EventsViewController: UIViewController {
    

    private var containerView: UIView!

    /// Reference for SearchBar.
    private var searchBar: SearchBar!
    
    
    /// NavigationBar menu button.
    private var menuButton: IconButton!
    

    /// NavigationBar profile button.
    private var profileButton: IconButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareMenuButton()
        prepareProfileButton()
        prepareContainerView()
        prepareSearchBar()
        prepareTableView()
        prepareNavigationItem()
        prepareNavigationBar()
    }
    
        
    /// General preparation statements.
        private func prepareView() {
            view.backgroundColor = MaterialColor.white
        }


    /// Prepares the menuButton.
    private func prepareMenuButton() {
        let image: UIImage? = MaterialIcon.cm.menu
        menuButton = IconButton()
        menuButton.pulseColor = MaterialColor.white
        menuButton.setImage(image, forState: .Normal)
        menuButton.setImage(image, forState: .Highlighted)
        menuButton.addTarget(self, action: #selector(handleMenuButton), forControlEvents: .TouchUpInside)
    }

    
    /// Handles the menuButton.
    internal func handleMenuButton() {
        let contactsViewController = ContactsViewController()
        let navc: NavigationController = NavigationController(rootViewController: contactsViewController)
        navc.modalTransitionStyle = .CrossDissolve
        presentViewController(navc, animated: true, completion: nil)
    }
    
    
    /// Prepares the profileButton.
    private func prepareProfileButton() {
        let image: UIImage? = MaterialIcon.cm.profileView
        profileButton = IconButton()
        profileButton.pulseColor = MaterialColor.white
        profileButton.setImage(image, forState: .Normal)
        profileButton.setImage(image, forState: .Highlighted)
        profileButton.addTarget(self, action: #selector(handleProfileButton), forControlEvents: .TouchUpInside)
    }
    
    
    /// Handles the profileButton.
    internal func handleProfileButton() {
        let profileViewController = ProfileViewController()
        let navc: NavigationController = NavigationController(rootViewController: profileViewController)
        navc.modalTransitionStyle = .CrossDissolve
        presentViewController(navc, animated: true, completion: nil)
    }
    
    
    /// Prepares the containerView.
    private func prepareContainerView() {
        containerView = UIView()
        view.layout(containerView).edges(top: 0, left: 0, right: 0)
    }


    /// Prepares the searchBar
    private func prepareSearchBar() {
    searchBar = SearchBar()
    containerView.addSubview(searchBar)
    let image: UIImage? = MaterialIcon.cm.moreVertical
    
    // More button.
    let moreButton: IconButton = IconButton()
    moreButton.pulseColor = MaterialColor.grey.base
    moreButton.tintColor = MaterialColor.grey.darken4
    moreButton.setImage(image, forState: .Normal)
    moreButton.setImage(image, forState: .Highlighted)
    
    /*
     To lighten the status bar - add the
     "View controller-based status bar appearance = NO"
     to your info.plist file and set the following property.
     */
    searchBar.leftControls = [moreButton]
    }

    
    /// Prepares the tableView
    
    private func prepareTableView() {
        displayContentController(MenuViewController(), frame: CGRect(x: 0, y: searchBar.bounds.maxY, width: view.bounds.size.width, height: view.bounds.size.height - searchBar.bounds.size.height))
    }
    
    

    /// Prepares the navigationItem.
    private func prepareNavigationItem() {
        navigationItem.title = "Events"
        navigationItem.titleLabel.textAlignment = .Center
        navigationItem.titleLabel.font = RobotoFont.mediumWithSize(14)
        
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
    }
    
    
}


