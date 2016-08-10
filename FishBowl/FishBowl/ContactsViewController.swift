//
//  MenuViewController.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-06-25.
//  Copyright (c) 2015 Adam Dahan. All rights reserved.
//

import UIKit
import Material

public class ContactsViewController: UIViewController {
    
    public lazy var tableView: UITableView = UITableView()
    
    private var containerView: UIView!
    
    /// Reference for SearchBar.
    private var searchBar: SearchBar!

    /*
    @name   viewDidLoad
    */
    public override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareContainerView()
        prepareSearchBar()
        prepareTableView()

    }
    
    /*
    @name   viewDidLayoutSubviews
    */
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableView()
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
    


}
