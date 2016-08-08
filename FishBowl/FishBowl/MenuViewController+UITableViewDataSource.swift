//
//  MenuViewController+UITableViewDataSource.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-06-25.
//  Copyright (c) 2015 Adam Dahan. All rights reserved.
//

import UIKit

extension MenuViewController: UITableViewDataSource {
    /*
    @name   numberOfSectionsInTableView
    */
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return MenuModel.sectionsCount()
    }
    
    /*
    @name   numberOfRowsInSection
    */
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sections = MenuModel.sections()
        let key = Array(sections.keys)[section]
        let section = sections[key] as! [String]
        return section.count
    }
    
    /*
    @name   cellForRowAtIndexPath
    */
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: DefaultTableViewCell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! DefaultTableViewCell
        return cell
    }
    
    /*
    @name   heightForHeaderInSection
    */
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    /*
    @name   titleForHeaderInSection
    */
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Default Section Title"
    }
}
