
import UIKit

public extension ContactsViewController {
    
    // prepareView
    
    public func prepareView() {
        view.backgroundColor = UIColor.redColor()
    }
    
    // prepareTableView
    
        public func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(ContactsTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    
    // layoutTableView
    
        public func layoutTableView() {
        tableView.frame = view.bounds
    }
}
