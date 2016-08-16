
import UIKit

extension ContactsViewController: UITableViewDataSource {
    

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
        if(searchActive) {
            return filtered.count
        }

        
        let rows = ContactsModel().getUsers().count
        
        return rows
    }
    
    /*
    @name   cellForRowAtIndexPath
    */
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ContactsTableViewCell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! ContactsTableViewCell
        
        if(searchActive){
            let users = ContactsModel().getUsers() // VIV NOT RETURNING RIGHT TITLE AND IMAGE

            cell.nameLabel.text = filtered[indexPath.row]
            for user in users
            {if user.name == filtered[indexPath.row] {cell.titleLabel.text = user.bio}}
            
            for user in users
            {if user.name == filtered[indexPath.row] {cell.profileView.image = UIImage(data: user.image!)}}

            
        } else {
            let users = ContactsModel().getUsers()
            let user = users[indexPath.row]
        
        cell.nameLabel.text = user.name
        cell.titleLabel.text = user.bio
        cell.profileView.image = UIImage(data: user.image!)
        }
        return cell
    }

}