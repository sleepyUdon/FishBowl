//
//  Event.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-09.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//


import Foundation

class Event: NSObject {
    var eventId: String
    var title: String?
    var time: NSNumber
    var yesRsvpCount: NSInteger
    var eventStatus: String
    var eventDescription: String?
    
    
    init(eventId:String, title: String, time:NSNumber, yesRsvpCount: NSInteger, eventStatus: String)
    {
        self.eventId = eventId
        self.title = title
        self.time = time
        self.eventStatus = eventStatus
        self.yesRsvpCount = yesRsvpCount
        
    }
}