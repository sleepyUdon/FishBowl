//
//  ProfileViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material

class ProfileViewController: UIViewController {

    
    /// NavigationBar save button.
    private var saveButton: IconButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareSaveButton()
        prepareTableView()
        prepareNavigationItem()
        prepareNavigationBar()
    }
    
    
    /// General preparation statements.
    private func prepareView() {
        view.backgroundColor = MaterialColor.white
    }
    
    
    /// Prepares the saveButton.
    private func prepareSaveButton() {
        let image: UIImage? = MaterialIcon.cm.close
        saveButton = IconButton()
        saveButton.pulseColor = MaterialColor.white
        saveButton.setImage(image, forState: .Normal)
        saveButton.setImage(image, forState: .Highlighted)
        saveButton.addTarget(self, action: #selector(handleSaveButton), forControlEvents: .TouchUpInside)
    }

    
    
    /// Handles the saveButton.
    internal func handleSaveButton() {
        let eventsViewController = EventsViewController()
        self.navigationController?.pushViewController(eventsViewController, animated: true)

    }

    
    /// Prepares the tableView
    
    private func prepareTableView() {
        displayContentController(MenuViewController(), frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
    }
    
    
    
    /// Prepares the navigationItem.
    private func prepareNavigationItem() {
        navigationItem.title = "Profile"
        navigationItem.titleLabel.textAlignment = .Center
        navigationItem.titleLabel.font = RobotoFont.mediumWithSize(14)
        navigationItem.rightControls = [saveButton]
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
