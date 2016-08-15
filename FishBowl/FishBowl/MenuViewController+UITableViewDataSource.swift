

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
        
        let rows = eventsData.events.count
        
        return rows
    }
    
    /*
    @name   cellForRowAtIndexPath
    */
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: EventsTableViewCell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! EventsTableViewCell
        
        let events = eventsData.events
        let event = events[indexPath.row]
        

        let formatter = NSDateFormatter()
        //        formatter.dateStyle = .LongStyle  
        //NSDateFormatterStyle.LongStyle         
        formatter.dateFormat = "MMM dd, yy h:mm a"
        //        formatter.timeStyle = .ShortStyle         
        let someDate = DataManager.getDateFromMilliseconds(event.time)
        let dateString = formatter.stringFromDate(someDate)
        cell.defaultLabel.text = event.title
        cell.defaultDescription.text = dateString
        cell.defaultParticipants.text = event.yesRsvpCount.stringValue + " participants"
        cell.defaultDate.text = ""
        

        
        return cell
    }
    
}