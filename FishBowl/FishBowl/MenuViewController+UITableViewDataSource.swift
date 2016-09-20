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
            formatter.dateFormat = "EEEE, MMMM dd h:mma"
        let formatterDate = NSDateFormatter()
        formatterDate.dateFormat = "MMM dd, yy"
        let someDate = DataManager.getDateFromMilliseconds(event.time)
        let dateString = formatter.stringFromDate(someDate)
        
        let comparedDate = formatterDate.stringFromDate(someDate)

        let today = NSDate()
        let oneDay:Double = 60 * 60 * 24
        let tomorrow = today.dateByAddingTimeInterval(oneDay)
        let yesterday = today.dateByAddingTimeInterval(-(Double(oneDay)))

        let comparedToday = formatterDate.stringFromDate(today)
        let comparedYesterday = formatterDate.stringFromDate(yesterday)
        let comparedTomorrow = formatterDate.stringFromDate(tomorrow)
        
        if (comparedDate == comparedToday) {
            cell.dateLabel.text = "  ▶︎ " + "Today " + "• " + dateString
            cell.dateLabel.backgroundColor = MaterialColor.pink.lighten4
            cell.dateLabel.textColor = MaterialColor.pink.base
            cell.dateLabel.layer.borderWidth = 0.5
            cell.dateLabel.layer.borderColor = MaterialColor.pink.base.CGColor
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Middle, animated: true)
        } else if (comparedDate == comparedYesterday) {
            cell.dateLabel.text = "    " + "Yesterday " + "• " + dateString
            cell.dateLabel.backgroundColor = MaterialColor.grey.lighten3
            cell.dateLabel.textColor = Color.greyMedium
            cell.dateLabel.layer.borderWidth = 0.5
            cell.dateLabel.layer.borderColor = MaterialColor.grey.base.CGColor

        }  else if (comparedDate == comparedTomorrow) {
            cell.dateLabel.text = "    " + "Tomorrow " + "• " + dateString
            cell.dateLabel.backgroundColor = MaterialColor.grey.lighten3
            cell.dateLabel.textColor = Color.greyMedium
            cell.dateLabel.layer.borderWidth = 0.5
            cell.dateLabel.layer.borderColor = MaterialColor.grey.base.CGColor
        } else {
            cell.dateLabel.text =  "      " + dateString
            cell.dateLabel.backgroundColor = MaterialColor.grey.lighten3
            cell.dateLabel.textColor = Color.greyMedium
            cell.dateLabel.layer.borderWidth = 0.5
            cell.dateLabel.layer.borderColor = MaterialColor.grey.base.CGColor
        }
        cell.descriptionLabel.text = event.title
        cell.participantsLabel.text = event.yesRsvpCount.stringValue + " participants"
        cell.backgroundColor = MaterialColor.white

        return cell
    }
    


}
