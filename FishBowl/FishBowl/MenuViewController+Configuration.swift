//
//  MenuViewController+Configuration.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-06-25.
//  Copyright (c) 2015 Adam Dahan. All rights reserved.
//

import UIKit

public extension MenuViewController {
    /*
    @name   prepareView
    */
    public func prepareView() {
        view.backgroundColor = UIColor.redColor()
    }
    
    /*
    @name   prepareTableView
    */
    public func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(DefaultTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    /*
    @name   prepareTableViewHeader
    */
    public func prepareTableViewHeader() {
        tableView.tableHeaderView = tableViewHeaderView
    }
    
    /*
    @name   layoutTableView
    */
    public func layoutTableView() {
        tableView.frame = view.bounds
    }
    
    /*
    @name   layoutTableViewHeader
    */
    public func layoutTableViewHeader() {
    
    }
}
