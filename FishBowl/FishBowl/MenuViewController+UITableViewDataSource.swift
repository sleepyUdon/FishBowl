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
    public func numberOfSections(in tableView: UITableView) -> Int {
        return MenuModel.sectionsCount()
    }
    
    /*
    @name   numberOfRowsInSection
    */
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = eventsData.events.count
        return rows
    }
    
    /*
    @name   cellForRowAtIndexPath
    */
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: EventsTableViewCell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! EventsTableViewCell
        let events = eventsData.events
        let event = events[(indexPath as NSIndexPath).row]
        let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yy h:mm a"
        let someDate = DataManager.getDateFromMilliseconds(event.time)
        let dateString = formatter.string(from: someDate)
        
        cell.defaultLabel.text = event.title
        cell.defaultDescription.text = "    " + dateString
        cell.defaultParticipants.text = event.yesRsvpCount.stringValue + " participants"
        cell.defaultDate.text = ""
        
        let seconds = Date().timeIntervalSince1970
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

