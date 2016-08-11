//
//  MenuViewController+UITableViewDataSource.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-06-25.
//  Copyright (c) 2015 Adam Dahan. All rights reserved.
//

import UIKit

extension ContactsViewController: UITableViewDataSource {
    
//    public lazy var menumodel:MenuModel = MenuModel()
   
    /*
    @name   numberOfSectionsInTableView
    */
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /*
    @name   numberOfRowsInSection
    */
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var sections = MenuModel.sections()
//        let key = Array(sections.keys)[section]
//        let section = sections[key] as! [String]
        
        let rows = ContactsModel().getUsers().count
        
        return rows
    }
    
    /*
    @name   cellForRowAtIndexPath
    */
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ContactsTableViewCell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! ContactsTableViewCell
        
        let users = ContactsModel().getUsers()
        let user = users[indexPath.row]
        
        cell.nameLabel.text = user.name
        cell.titleLabel.text = user.title
        cell.profileView.image = UIImage(data: user.image!)
        
        return cell
    }
    
}