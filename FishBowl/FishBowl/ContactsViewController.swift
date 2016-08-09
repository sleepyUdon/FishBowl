//
//  ContactsViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//


import UIKit
import Material

private struct Item {
    var text: String
    var imageName: String
}

class ContactsViewController: UIViewController {
    
    
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
        prepareLargeCardViewExample()

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
        menuButton.tintColor = UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100)
        menuButton.setImage(image, forState: .Normal)
        menuButton.setImage(image, forState: .Highlighted)
        menuButton.addTarget(self, action: #selector(handleMenuButton), forControlEvents: .TouchUpInside)
    }
    
    
    /// Handles the menuButton.
    internal func handleMenuButton() {
        navigationDrawerController?.openLeftView()
        
    }
    
    
    /// Prepares the profileButton.
    private func prepareProfileButton() {
        let image: UIImage? = MaterialIcon.cm.profileView
        profileButton = IconButton()
        profileButton.pulseColor = MaterialColor.white
        profileButton.tintColor = UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100)
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
    
    
    /// Prepares the tableView
    
    private func prepareTableView() {
        displayContentController(MenuViewController(), frame: CGRect(x: 0, y: searchBar.bounds.maxY, width: view.bounds.size.width, height: view.bounds.size.height - searchBar.bounds.size.height))
    }
    
    
    
    /// Prepares the navigationItem.
    private func prepareNavigationItem() {
        navigationItem.title = "Events"
        navigationItem.titleLabel.textAlignment = .Center
        navigationItem.titleLabel.textColor = MaterialColor.white
        navigationItem.titleLabel.font = UIFont(name: "Avenir", size: 15)
        
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
        navigationController?.navigationBar.backgroundColor = MaterialColor.blueGrey.darken4
        
    }
    
    // Layout View
    
    private func prepareLargeCardViewExample() {
        var image: UIImage? = UIImage(named: "CosmicMindInverted")
        
        let cardView: MaterialPulseView = MaterialPulseView(frame: CGRectMake(16, 100, view.bounds.width - 32, 400))
        cardView.pulseColor = MaterialColor.blueGrey.base
        cardView.depth = .Depth1
        view.addSubview(cardView)
        
        let leftImageView: MaterialView = MaterialView()
        leftImageView.image = image
        leftImageView.contentsGravityPreset = .ResizeAspectFill
        cardView.addSubview(leftImageView)
        
        let topImageView: MaterialView = MaterialView()
        topImageView.image = image
        topImageView.contentsGravityPreset = .ResizeAspectFill
        cardView.addSubview(topImageView)
        
        let bottomImageView: MaterialView = MaterialView()
        bottomImageView.image = image
        bottomImageView.contentsGravityPreset = .ResizeAspectFill
        cardView.addSubview(bottomImageView)
        
        let contentView: MaterialView = MaterialView()
        contentView.backgroundColor = MaterialColor.clear
        cardView.addSubview(contentView)
        
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "Material"
        titleLabel.textColor = MaterialColor.blueGrey.darken4
        titleLabel.backgroundColor = MaterialColor.clear
        contentView.addSubview(titleLabel)
        
        image = MaterialIcon.cm.moreHorizontal
        let moreButton: IconButton = IconButton()
        moreButton.contentEdgeInsetsPreset = .None
        moreButton.pulseColor = MaterialColor.blueGrey.darken4
        moreButton.tintColor = MaterialColor.blueGrey.darken4
        moreButton.setImage(image, forState: .Normal)
        moreButton.setImage(image, forState: .Highlighted)
        contentView.addSubview(moreButton)
        
        let detailLabel: UILabel = UILabel()
        detailLabel.numberOfLines = 0
        detailLabel.lineBreakMode = .ByTruncatingTail
        detailLabel.font = RobotoFont.regularWithSize(12)
        detailLabel.text = "Express your creativity with Material, an animation and graphics framework for Google's Material Design and Apple's Flat UI in Swift."
        detailLabel.textColor = MaterialColor.blueGrey.darken4
        detailLabel.backgroundColor = MaterialColor.clear
        contentView.addSubview(detailLabel)
        
        let alarmLabel: UILabel = UILabel()
        alarmLabel.font = RobotoFont.regularWithSize(12)
        alarmLabel.text = "34 min"
        alarmLabel.textColor = MaterialColor.blueGrey.darken4
        alarmLabel.backgroundColor = MaterialColor.clear
        contentView.addSubview(alarmLabel)
        
        image = UIImage(named: "ic_alarm_white")?.imageWithRenderingMode(.AlwaysTemplate)
        let alarmButton: IconButton = IconButton()
        alarmButton.contentEdgeInsetsPreset = .None
        alarmButton.pulseColor = MaterialColor.blueGrey.darken4
        alarmButton.tintColor = MaterialColor.red.base
        alarmButton.setImage(image, forState: .Normal)
        alarmButton.setImage(image, forState: .Highlighted)
        contentView.addSubview(alarmButton)
        
        leftImageView.grid.rows = 7
        leftImageView.grid.columns = 6
        
        topImageView.grid.rows = 4
        topImageView.grid.columns = 6
        topImageView.grid.offset.columns = 6
        
        bottomImageView.grid.rows = 3
        bottomImageView.grid.offset.rows = 4
        bottomImageView.grid.columns = 6
        bottomImageView.grid.offset.columns = 6
        
        contentView.grid.rows = 5
        contentView.grid.offset.rows = 7
        
        cardView.grid.axis.direction = .None
        cardView.grid.spacing = 4
        cardView.grid.views = [
            leftImageView,
            topImageView,
            bottomImageView,
            contentView
        ]
        
        titleLabel.grid.rows = 3
        titleLabel.grid.columns = 8
        
        moreButton.grid.rows = 3
        moreButton.grid.columns = 2
        moreButton.grid.offset.columns = 10
        
        detailLabel.grid.rows = 6
        detailLabel.grid.offset.rows = 3
        
        alarmLabel.grid.rows = 3
        alarmLabel.grid.columns = 8
        alarmLabel.grid.offset.rows = 9
        
        alarmButton.grid.rows = 3
        alarmButton.grid.offset.rows = 9
        alarmButton.grid.columns = 2
        alarmButton.grid.offset.columns = 10
        
        contentView.grid.spacing = 8
        contentView.grid.axis.direction = .None
        contentView.grid.contentInsetPreset = .Square3
        contentView.grid.views = [
            titleLabel,
            moreButton,
            detailLabel,
            alarmLabel,
            alarmButton
        ]

    
    
}
}