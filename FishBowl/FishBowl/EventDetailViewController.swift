//
//  EventDetailViewController.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import UIKit
import Material

class EventDetailViewController: UIViewController {

    private var containerView: UIView!
    
    /// Reference for SearchBar.
    private var searchBar: SearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
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
        navigationItem.titleLabel.textColor = MaterialColor.white
        navigationItem.titleLabel.textAlignment = .Center
        navigationItem.titleLabel.font = UIFont(name: "Avenir", size: 15)
        
    }
    
    /// Prepares the navigationBar.
    private func prepareNavigationBar() {
        /**
         To control this setting, set the "View controller-based status bar appearance"
         to "NO" in the info.plist.
         */
        navigationController?.navigationBar.statusBarStyle = .LightContent
        navigationController?.navigationBar.backgroundColor = MaterialColor.blueGrey.darken4
        navigationController?.navigationBar.tintColor = UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100)
    }
    
    
    /// Prepares the cells within the tableView.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: EventDetailTableViewCell = tableView.dequeueReusableCellWithIdentifier("MaterialTableViewCell", forIndexPath: indexPath) as! EventDetailTableViewCell
        
        //VIV PASS DATA
        
//        let item: Item = items[indexPath.row]
//        
//        cell.textLabel!.text = item.text
//        cell.textLabel!.textColor = MaterialColor.grey.lighten2
//        cell.textLabel!.font = RobotoFont.medium
//        cell.imageView!.image = UIImage(named: item.imageName)?.imageWithRenderingMode(.AlwaysTemplate)
//        cell.imageView!.tintColor = MaterialColor.grey.lighten2
        cell.backgroundColor = MaterialColor.clear
        
        return cell
    }

    
}

