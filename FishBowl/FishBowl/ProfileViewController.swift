//
//  ProfileViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material

/// NavigationBar save button.
private var saveButton: MaterialButton!


class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSaveButton()
        prepareLargeCardViewExample()
        prepareNavigationItem()
        prepareNavigationBar()
    }
    
    private func prepareSaveButton() {
        saveButton = MaterialButton()
        saveButton.setTitle("Save", forState: .Normal)
        saveButton.setTitleColor(UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100), forState: .Normal)
        saveButton.pulseColor = MaterialColor.white
        saveButton.titleLabel!.font = UIFont(name: "Avenir", size: 15)
        saveButton.addTarget(self, action: #selector(handleSaveButton), forControlEvents: .TouchUpInside)
    }

    
    /// Handles the saveButton.
    internal func handleSaveButton() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    // Layout View
    
    private func prepareLargeCardViewExample() {
        //        _: UIImage? = UIImage(named: "CosmicMindInverted")
        
        let cardView: MaterialPulseView = MaterialPulseView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        cardView.pulseColor = MaterialColor.white
        view.addSubview(cardView)
        
        let switchbutton = MaterialSwitch(state: .On, style: .Default, size: .Small)
        switchbutton.trackOnColor = UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100)
        switchbutton.buttonOnColor = MaterialColor.blueGrey.darken4
        switchbutton.buttonOffColor = MaterialColor.blueGrey.darken4
        view.addSubview(switchbutton)

        let shareContact: UILabel = UILabel()
        shareContact.text = "Share Contacts"
        shareContact.font = UIFont(name: "Avenir", size: 15)
        shareContact.textColor = MaterialColor.black
        view.addSubview(shareContact)
        
        let photoView: MaterialView = MaterialView()
        photoView.image = MaterialIcon.photoCamera!
        photoView.backgroundColor = MaterialColor.black
        photoView.shape = .Square
        view.addSubview(photoView)

        let photoLabel: UILabel = UILabel()
        photoLabel.text = "Photo"
        photoLabel.font = UIFont(name: "Avenir", size: 15)
        photoLabel.textColor = MaterialColor.black
        view.addSubview(photoLabel)
        
        let profileView: MaterialView = MaterialView()
        profileView.image = UIImage(named: "VivianeChan")
        profileView.shape = .Circle
        view.addSubview(profileView)
        
        let nameView: MaterialView = MaterialView()
        nameView.image = MaterialIcon.cm.profileView
        nameView.backgroundColor = MaterialColor.black
        nameView.shape = .Square
        view.addSubview(nameView)


        let nameLabel: UILabel = UILabel()
        nameLabel.text = "Name"
        nameLabel.font = UIFont(name: "Avenir", size: 15)
        nameLabel.textColor = MaterialColor.black
        view.addSubview(nameLabel)

        let titleLabel: UILabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = UIFont(name: "Avenir", size: 15)
        titleLabel.textColor = MaterialColor.black
        view.addSubview(titleLabel)
        
        let companyLabel: UILabel = UILabel()
        companyLabel.text = "Company"
        companyLabel.font = UIFont(name: "Avenir", size: 15)
        companyLabel.textColor = MaterialColor.black
        view.addSubview(companyLabel)
        
        let emailLabel: UILabel = UILabel()
        emailLabel.text = "Email"
        emailLabel.font = UIFont(name: "Avenir", size: 15)
        emailLabel.textColor = MaterialColor.black
        view.addSubview(emailLabel)
        
        let passwordLabel: UILabel = UILabel()
        passwordLabel.text = "*****"
        passwordLabel.font = UIFont(name: "Avenir", size: 15)
        passwordLabel.textColor = MaterialColor.black
        view.addSubview(passwordLabel)
        
        let phoneLabel: UILabel = UILabel()
        phoneLabel.text = "(647)836.5162"
        phoneLabel.font = UIFont(name: "Avenir", size: 15)
        phoneLabel.textColor = MaterialColor.black
        view.addSubview(phoneLabel)

        let githubLabel: UILabel = UILabel()
        githubLabel.text = "github.com/sleepyUdon"
        githubLabel.font = UIFont(name: "Avenir", size: 15)
        githubLabel.textColor = MaterialColor.black
        view.addSubview(githubLabel)
        
        let linkedinLabel: UILabel = UILabel()
        linkedinLabel.text = "linkedIn/vivianechan"
        linkedinLabel.font = UIFont(name: "Avenir", size: 15)
        linkedinLabel.textColor = MaterialColor.black
        view.addSubview(linkedinLabel)

        switchbutton.grid.rows = 1
        switchbutton.grid.columns = 3
        switchbutton.grid.offset.columns = 9
        
        shareContact.grid.rows = 1
        shareContact.grid.columns = 8
        
        photoView.grid.rows = 1
        photoView.grid.columns = 2
        photoView.grid.offset.rows = 1
        photoView.grid.offset.columns = 0

        photoLabel.grid.rows = 1
        photoLabel.grid.columns = 5
        photoLabel.grid.offset.rows = 1
        photoLabel.grid.offset.columns = 2
        
        profileView.grid.rows = 1
        profileView.grid.columns = 2
        profileView.grid.offset.rows = 1
        profileView.grid.offset.columns = 9

        nameLabel.grid.rows = 1
        nameLabel.grid.columns = 8
        nameLabel.grid.offset.rows = 2
        nameLabel.grid.offset.columns = 2

        titleLabel.grid.rows = 1
        titleLabel.grid.columns = 8
        titleLabel.grid.offset.rows = 3
        titleLabel.grid.offset.columns = 2
        
        companyLabel.grid.rows = 1
        companyLabel.grid.columns = 8
        companyLabel.grid.offset.rows = 4
        companyLabel.grid.offset.columns = 2
        
        emailLabel.grid.rows = 1
        emailLabel.grid.columns = 8
        emailLabel.grid.offset.rows = 5
        emailLabel.grid.offset.columns = 2
        
        passwordLabel.grid.rows = 1
        passwordLabel.grid.columns = 8
        passwordLabel.grid.offset.rows = 6
        passwordLabel.grid.offset.columns = 2

        phoneLabel.grid.rows = 1
        phoneLabel.grid.columns = 8
        phoneLabel.grid.offset.rows = 7
        phoneLabel.grid.offset.columns = 2
        
        githubLabel.grid.rows = 1
        githubLabel.grid.columns = 8
        githubLabel.grid.offset.rows = 8
        githubLabel.grid.offset.columns = 2
        
        linkedinLabel.grid.rows = 1
        linkedinLabel.grid.columns = 8
        linkedinLabel.grid.offset.rows = 9
        linkedinLabel.grid.offset.columns = 2
        

        cardView.grid.spacing = 2
        cardView.grid.axis.direction = .None
        cardView.grid.contentInsetPreset = .Square3
        cardView.grid.views = [
            photoView,
            photoLabel,
            shareContact,
            profileView,
            nameLabel,
            titleLabel,
            companyLabel,
            emailLabel,
            passwordLabel,
            phoneLabel,
            githubLabel,
            linkedinLabel,
            switchbutton,
            profileView
        ]
    }
 
    
    /// Prepares the navigationItem.
    private func prepareNavigationItem() {
        navigationItem.title = "Profile"
        navigationItem.titleLabel.textAlignment = .Center
        navigationItem.titleLabel.textColor = MaterialColor.white
        navigationItem.titleLabel.font = UIFont(name: "Avenir", size: 15)
        navigationItem.rightControls = [saveButton]

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
