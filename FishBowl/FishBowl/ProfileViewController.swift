//
//  ProfileViewController.swift
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


class ProfileViewController: UIViewController {
    
    /// A tableView used to display navigation items.
    private let tableView: UITableView = UITableView()

    /// NavigationBar save button.
    private var saveButton: IconButton!

    /// A list of all the navigation items.
    private var items: Array<Item> = Array<Item>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareSaveButton()
        prepareCells()
        prepareTableView()
        prepareNavigationItem()
        prepareNavigationBar()
    }
    
    
    /// General preparation statements.
    private func prepareView() {
        view.backgroundColor = MaterialColor.white
    }
    
    
    /// Prepares the items that are displayed within the tableView.
    private func prepareCells() {
        items.append(Item(text: "Photo", imageName: "ic_menu_white"))
        items.append(Item(text: "Name", imageName: "ic_inbox"))
        items.append(Item(text: "Title", imageName: "ic_inbox"))
        items.append(Item(text: "Company", imageName: "ic_inbox"))
        items.append(Item(text: "Email", imageName: "ic_inbox"))
        items.append(Item(text: "Password", imageName: "ic_inbox"))
        items.append(Item(text: "Phone", imageName: "ic_inbox"))
        items.append(Item(text: "Github", imageName: "ic_inbox"))
        items.append(Item(text: "Linked", imageName: "ic_inbox"))
        items.append(Item(text: "Disconnect from Meetup Account", imageName: "ic_inbox"))

    }

    

    /// Prepares the tableView.
    private func prepareTableView() {
        tableView.registerClass(MaterialTableViewCell.self, forCellReuseIdentifier: "MaterialTableViewCell")
        tableView.backgroundColor = MaterialColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .SingleLineEtched
        
        // Use Layout to easily align the tableView.
        view.layout(tableView).edges(top: 0)
    }
}


/// TableViewDataSource methods.
extension ProfileViewController: UITableViewDataSource {
    /// Determines the number of rows in the tableView.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    /// Prepares the cells within the tableView.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MaterialTableViewCell = tableView.dequeueReusableCellWithIdentifier("MaterialTableViewCell", forIndexPath: indexPath) as! MaterialTableViewCell
        
        let item: Item = items[indexPath.row]
        
        cell.textLabel!.text = item.text
        cell.textLabel!.textColor = MaterialColor.black
        cell.textLabel!.font = UIFont(name: "Avenir", size: 15)
        cell.imageView!.image = UIImage(named: item.imageName)?.imageWithRenderingMode(.AlwaysTemplate)
        cell.imageView!.tintColor = MaterialColor.grey.lighten2
        cell.backgroundColor = MaterialColor.clear
        
        return cell
    }
}
   
/// UITableViewDelegate methods.
extension ProfileViewController: UITableViewDelegate {
    /// Sets the tableView cell height.
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    /// Select item at row in tableView.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //		print("Selected")
    }

    

    
    /// Prepares the saveButton.
    private func prepareSaveButton() {
        let image: UIImage? = MaterialIcon.cm.close
        saveButton = IconButton()
        saveButton.pulseColor = MaterialColor.white
        saveButton.tintColor = MaterialColor.white
        saveButton.setImage(image, forState: .Normal)
        saveButton.setImage(image, forState: .Highlighted)
        saveButton.addTarget(self, action: #selector(handleSaveButton), forControlEvents: .TouchUpInside)
    }

    
    
    /// Handles the saveButton.
    internal func handleSaveButton() {
        let eventsViewController = EventsViewController()
        let navc: NavigationController = NavigationController(rootViewController: eventsViewController)
        navc.modalTransitionStyle = .CrossDissolve
        presentViewController(navc, animated: true, completion: nil)

    }

    
    
    
    /// Prepares the navigationItem.
    private func prepareNavigationItem() {
        navigationItem.title = "Profile"
        navigationItem.titleLabel.textColor = MaterialColor.white
        navigationItem.titleLabel.tintColor = UIColor(red: 175/255, green: 165/255, blue: 118/255, alpha: 100)
        navigationItem.titleLabel.textAlignment = .Center
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
