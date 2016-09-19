//  MenuViewControllerDataSource.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io . All rights reserved.

import UIKit
import Material

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
            formatter.dateFormat = "MMM dd, yy h:mm a"
        let someDate = DataManager.getDateFromMilliseconds(event.time)
        let dateString = formatter.stringFromDate(someDate)
        
        cell.dateLabel.text = event.title
        cell.descriptionLabel.text = "    " + dateString
        cell.participantsLabel.text = event.yesRsvpCount.stringValue + " participants"
        
        let seconds = NSDate().timeIntervalSince1970
        let milliseconds = seconds * 1000.0

        // grey out past events
        if (milliseconds > event.time.doubleValue) {
            cell.backgroundColor = MaterialColor.grey.lighten2
        }
        else {
            cell.backgroundColor = MaterialColor.white
        }
        
        return cell
    }
}

