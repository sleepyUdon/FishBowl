

import UIKit

extension ParticipantsViewController: UITableViewDataSource {
    
//    public lazy var menumodel:MenuModel = MenuModel()
    /*
    @name   numberOfSectionsInTableView
    */
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ParticipantsModel.sectionsCount()
    }
    
    /*
    @name   numberOfRowsInSection
    */
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var sections = MenuModel.sections()
//        let key = Array(sections.keys)[section]
//        let section = sections[key] as! [String]
        
        return membersData.members.count
    }
    
    /*
    @name   cellForRowAtIndexPath
    */
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ParticipantsTableViewCell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! ParticipantsTableViewCell
        cell.selectionStyle = .None
        
        let members = membersData.members
        //debugPrint("Members with no images!")
        //debugPrint(members.filter({$0.memberImage == nil}))
        let member = members[indexPath.row]
        if let imageData = member.memberImage {
            let image = UIImage(data: imageData)
            cell.profileView.image = image

        }
        else {
            cell.profileView.image = UIImage(named: "photoplaceholder.png")
        }
        cell.titleLabel.text = member.memberBio
        cell.nameLabel.text = member.memberName
        
        
        return cell
    }
    
    
    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    public func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        var addAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Add" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // 2
            let shareMenu = UIAlertController(title: nil, message: "Add to contact list", preferredStyle: .ActionSheet)
            
            let addAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: nil)
            
            shareMenu.addAction(addAction)
            
            
            self.presentViewController(shareMenu, animated: true, completion: nil)
        })
        
        return [addAction]
    }

}