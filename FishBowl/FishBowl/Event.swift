//
//  Event.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-09.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//


import Foundation

class Event: NSObject {
    var title: String
    var location: String
    var date: NSDate
    var group: String
    //    var participants: participants()
    
    
    init(title: String, location:String,date:NSDate, group: String) {
        self.title = title
        self.location = location
        self.date = date
        self.group = group
        
    }
}