

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
        tableView.registerClass(EventsTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    
    /*
    @name   layoutTableView
    */
    public func layoutTableView() {
        tableView.frame = view.bounds
    }
}
