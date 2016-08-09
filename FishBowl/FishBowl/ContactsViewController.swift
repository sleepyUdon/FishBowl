//
//  ContactsViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material

class ContactsViewController: UIViewController {

    private var containerView: UIView!
    
    /// Reference for SearchBar.
    private var searchBar: SearchBar!
    
    private var backButton: IconButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareContainerView()
        prepareSearchBar()
        prepareBackButton()
        prepareTableView()
        prepareNavigationItem()
        prepareNavigationBar()
    }

    
    /// General preparation statements.
    private func prepareView() {
        view.backgroundColor = MaterialColor.white
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
        let image: UIImage? = MaterialIcon.cm.search
        
        // More button.
        let moreButton: IconButton = IconButton()
        moreButton.pulseColor = MaterialColor.grey.base
        moreButton.tintColor = UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100)
        moreButton.setImage(image, forState: .Normal)
        moreButton.setImage(image, forState: .Highlighted)
        
        /*
         To lighten the status bar - add the
         "View controller-based status bar appearance = NO"
         to your info.plist file and set the following property.
         */
        searchBar.leftControls = [moreButton]
    }

    
    /// Prepares the backButton.
    private func prepareBackButton() {
        let image: UIImage? = MaterialIcon.cm.close
        backButton = IconButton()
        backButton.pulseColor = MaterialColor.white
        backButton.tintColor = MaterialColor.white
        backButton.setImage(image, forState: .Normal)
        backButton.setImage(image, forState: .Highlighted)
        backButton.addTarget(self, action: #selector(handleCloseButton), forControlEvents: .TouchUpInside)

    }
    
    
    /// Handles the CloseButton.
    internal func handleCloseButton() {
        let eventsViewController = EventsViewController()
        self.navigationController?.pushViewController(eventsViewController, animated: true)

    }


    
    /// Prepares the tableView
    
    private func prepareTableView() {
        displayContentController(MenuViewController(), frame: CGRect(x: 0, y: searchBar.bounds.maxY, width: view.bounds.size.width, height: view.bounds.size.height - searchBar.bounds.size.height))
    }
    
    
    /// Prepares the navigationItem.
    private func prepareNavigationItem() {
        navigationItem.title = "Contacts"
        navigationItem.titleLabel.textAlignment = .Center
        navigationItem.titleLabel.textColor = MaterialColor.white
        navigationItem.titleLabel.font = UIFont(name: "Avenir", size: 15)
        navigationItem.rightControls = [backButton]

    }
    
    
    /// Prepares the navigationBar.
    private func prepareNavigationBar() {
        /**
         To control this setting, set the "View controller-based status bar appearance"
         to "NO" in the info.plist.
         */
        navigationController?.navigationBar.statusBarStyle = .LightContent
        navigationController?.navigationBar.backgroundColor = MaterialColor.blueGrey.darken4

    }
    
    
}

