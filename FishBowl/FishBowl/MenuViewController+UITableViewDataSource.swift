

import UIKit

extension MenuViewController: UITableViewDataSource {
    
//    public lazy var menumodel:MenuModel = MenuModel()
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
//        var sections = MenuModel.sections()
//        let key = Array(sections.keys)[section]
//        let section = sections[key] as! [String]
        
        let rows = MenuModel().getEvents().count
        
        return rows
    }
    
    /*
    @name   cellForRowAtIndexPath
    */
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: EventsTableViewCell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! EventsTableViewCell
        
        let events = MenuModel().getEvents()
        let event = events[indexPath.row]
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        let dateString = formatter.stringFromDate(event.date)
        
        cell.defaultLabel.text = event.title            // Change the label names
        cell.defaultDescription.text = event.group      // together with those in
        cell.defaultParticipants.text = dateString      // EventsTableViewCell
        cell.defaultDate.text = dateString
        
        return cell
    }
    
}