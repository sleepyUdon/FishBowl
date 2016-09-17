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

    func grabUserFromAPI(_ handler:@escaping (_ userInfo: [String:AnyObject])->()) {
        let api = APIController()
        
        api.getUserDetails(AppDelegate.token!, handler: { (userDict: NSDictionary) in
            self.user["id"] = userDict["id"]!.stringValue
            self.user["name"] = userDict["name"] as? String
            self.user["title"] = userDict["bio"] as? String
            handler(userInfo: self.user)
        })
    }
    
    class func grabEventsFromAPI(_ handler:@escaping (_ events: [Event])->()){
        
        var eventsArray:[Event] = []
        let api = APIController()
        
        if AppDelegate.token != nil {
            
            api.getEvents(AppDelegate.token!, handler: { (eventsDict: NSArray) in
                
                for result in eventsDict {
                    let eventId = result["id"] as! String
                    let eventName = result["name"] as! String
                    let eventTime = result["time"] as! NSNumber
                    let eventYesRsvpCount = result["yes_rsvp_count"] as! NSInteger
                    let eventStatus = result["status"] as! String
                    
                    //create an event object
                    let eventItem = Event.init(eventId:eventId, title: eventName, time:eventTime, yesRsvpCount: eventYesRsvpCount, eventStatus: eventStatus)
                    //print(self.eventItem)
                    
                    //now add eventItem object to events array
                    eventsArray.append(eventItem)
                    
                }
                handler(events: eventsArray)
            })
        }
        
    }
    
    func grabMembersFromAPI(_ handler:@escaping (_ members:[Member])->()) {
        
        var membersArray:[Member] = []
        let api = APIController()
        
        api.getRSVPs(self.eventId, token: AppDelegate.token!, handler: { (membersDict: NSDictionary) in
            if let memberResults = membersDict["results"] as? [[String:AnyObject]] {
                //go through every member
                for memberObject in memberResults {
                    var memberImageData: Data?
                    if let memberPhoto = memberObject["member_photo"] as? NSDictionary{
                        //get photo of the member
                        let memberPhotoLink = memberPhoto["thumb_link"] as! String
                        let url: URL = URL(string: memberPhotoLink as String)!
                        
                        let task = URLSession.shared.dataTask(with: url, completionHandler: {
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
                                //print(memberName, memberId)
                                
                                //create member object
                                let member = Member.init(memberId: memberId, memberName: memberName, memberImage: memberImageData)
                                membersArray.append(member)
                                //print(membersArray)
                                handler(members: membersArray)
                            }
                        })
                        task.resume()
                    }
                }
            }
        })
    }
    
    class func getDateFromMilliseconds(_ ms: NSNumber) -> Date {
        
        let msec = ms.intValue
        let date  = Date(timeIntervalSince1970:Double(msec) / 1000.0)
        return date
        
    }
    
    class func getMemberFromContacts() -> Array<User>{

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
            result = try moc.fetch(fetchRequest) as! Array<User>
            print(result)
            
        }
        catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return result
    }
    
}
