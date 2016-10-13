//  DataManager.swift
//  FishBowl
//
//  Created by Yevhen Kim on 2016-08-24.
//  Copyright © 2016 Komrad.io. All rights reserved.


import Foundation
import UIKit
import CoreData
import OAuthSwift


class DataManager: NSObject {
    
    var eventId: String!
    var contacts: [User] = []
    var user: [String:AnyObject] = [:]

    func grabUserFromAPI(handler:(userInfo: [String:AnyObject])->()) {
        let api = APIController()
        api.getUserDetails(AppDelegate.token!, handler: { (userDict: NSDictionary) in
            self.user["id"] = userDict["id"]!.stringValue
            self.user["name"] = userDict["name"] as? String
            self.user["title"] = userDict["bio"] as? String
            handler(userInfo: self.user)
        })
    }
    
    class func grabEventsFromAPI(handler:(events: [Event])->()){
        var eventsArray:[Event] = []
        let api = APIController()
        
        if AppDelegate.token != nil {
            api.getEvents(AppDelegate.token!, handler: { (eventsDict: NSArray) in
                for result in eventsDict {
                    let todayMS = Double(NSDate().timeIntervalSince1970 * 1000.0)
                    let fourteenDays:Double = 10 * 60 * 60 * 60 * 24 * 14
                    let twoWeekAgo = todayMS - fourteenDays
                    let eventTime = Double(result["time"] as! NSNumber)
                    
                    if  eventTime > twoWeekAgo {
                        let eventId = result["id"] as! String
                        let eventName = result["name"] as! String
                        let eventTime = result["time"] as! NSNumber
                        let eventYesRsvpCount = result["yes_rsvp_count"] as! NSInteger
                        let eventStatus = result["status"] as! String
                        
                        //create an event object
                        let eventItem = Event.init(eventId:eventId, title: eventName, time:eventTime, yesRsvpCount: eventYesRsvpCount, eventStatus: eventStatus)
                        
                        //now add eventItem object to events array
                        eventsArray.append(eventItem)
                    }
                }
                handler(events: eventsArray)
            })
        }
    }
    
    func grabMembersFromAPI(handler:(members:[Member])->()) {
        var membersArray:[Member] = []
        let api = APIController()
        
        api.getRSVPs(self.eventId, token: AppDelegate.token!, handler: { (membersDict: NSDictionary) in
            if let memberResults = membersDict["results"] as? [[String:AnyObject]] {
                //go through every member
                for memberObject in memberResults {
                    var memberImageData: NSData?
                    if let memberPhoto = memberObject["member_photo"] as? NSDictionary{
                        //get photo of the member
                        let memberPhotoLink = memberPhoto["thumb_link"] as! String
                        let url: NSURL = NSURL(string: memberPhotoLink as String)!
                        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
                            data, response, error in
                            //check for error
                            if error != nil {
                                print("error=\(error)")
                                return
                            }
                            
                            guard let data = data else {
                                print("data is nil")
                                return
                            }
                            
                            memberImageData = data
                            if let member = memberObject["member"] as? NSDictionary {
                                //get all details under every member
                                let memberId = member["member_id"]!.stringValue
                                let memberName = member["name"] as! String
                                
                                //create member object
                                let member = Member.init(memberId: memberId, memberName: memberName, memberImage: memberImageData)
                                membersArray.append(member)
                                handler(members: membersArray)
                            }
                        })
                        task.resume()
                    }
                }
            }
        })
    }
    
    class func getDateFromMilliseconds(ms: NSNumber) -> NSDate {
        let msec = ms.integerValue
        let date  = NSDate(timeIntervalSince1970:Double(msec) / 1000.0)
        return date
    }
    
    class func getMemberFromContacts() -> Array<User>{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        var result: [User] = []
        //create fetch request
        let fetchRequest = NSFetchRequest(entityName:"User")
        
        //add sort descriptor
        let sortDescriptor = NSSortDescriptor(key:"userID", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.returnsObjectsAsFaults = false
        //Execute Fetch Request
        do {
            result = try moc.executeFetchRequest(fetchRequest) as! Array<User>
            print(result)
            
        }
        catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return result
    }    
}
