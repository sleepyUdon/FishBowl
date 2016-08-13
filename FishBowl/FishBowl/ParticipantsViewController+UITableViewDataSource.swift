

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
        
        return 3
    }
    
    /*
    @name   cellForRowAtIndexPath
    */
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ParticipantsTableViewCell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! ParticipantsTableViewCell
        cell.selectionStyle = .None
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