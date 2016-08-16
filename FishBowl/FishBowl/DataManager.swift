//
//  DataManager.swift
//  FishBowl
//
//  Created by Rene Mojica on 2016-08-10.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import Foundation
import UIKit
import OAuthSwift
import Graph

class DataManager: NSObject {
    
    let graph = Graph()
    //let api = APIController()
    var contactList : [User] = []
    var eventId: String!
    
    class func createUserDummyData() -> [User] {
        
        var userList = [User]()
        
        let users : [Dictionary<String,AnyObject>] = [["name":"Justin Trudeau",
            "email":"justin.trudeau@parl.gc.ca",

            "phone":6478365162,
            "github":"",
            "linkedin":"https://ca.linkedin.com/in/justintrudeau",
            "title":"Prime Minister, Canada",
            "image": UIImagePNGRepresentation(UIImage(named:"justintrudeau")!)!],
            ["name":"Bill Gates", "email":"billg@microsoft.com.",
            "phone":6478365162,
            "github":"",
            "linkedin":"https://www.linkedin.com/in/williamhgates",
            "title":"Technology Advisor, Microsoft",
            "image":UIImagePNGRepresentation(UIImage(named:"billgates")!)!],
            ["name":"Larry Page",
            "email":"larry@google.com",

            "phone":6478365162,
            "github":"",
            "linkedin":"https://www.linkedin.com/in/tlytle",
            "title":"CEO, Alphabet Inc",
            "image": UIImagePNGRepresentation(UIImage(named:"larrypage")!)!],
            ["name":"Mark Zuckerberg",
            "email":"zuck@fb.com",

            "phone":6478365162,
            "github":"",
            "linkedin":"",
            "title":"Chairman and CEO, Facebook",
            "image": UIImagePNGRepresentation(UIImage(named:"markzuckerberg")!)!],
            ["name":"Marissa Mayer",
            "email":"marissa.mayer@yahoo-inc.com",

            "phone":6478365162,
            "github":"",
            "linkedin":"https://www.linkedin.com/in/marissamayer",
            "title":"CEO, Yahoo!",
            "image": UIImagePNGRepresentation(UIImage(named:"marissamayer")!)!]]
        
        for user in users {
            
            let name = user["name"] as! String
            let email = user["email"] as! String
            let phone = user["phone"] as! String
            let github = user["github"] as! String
            let linkedin = user["linkedin"] as! String
            let title = user["title"] as! String
            let image = user["image"] as? NSData
            
            let someUser = User(userId: "", name: "", bio: "", image: nil)
            someUser.name = name
            someUser.bio = title
            someUser.email = email
            someUser.phone = phone
            someUser.image = image
            someUser.linkedin = linkedin
            someUser.github = github
            
            userList.append(someUser)
            
        }
        
        return userList
    }

    class func createEventDummyData() -> [Event]{
        
        var eventList = [Event]()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let events = [["Group":"DevHub",
                        "EventTitle":"NSCoder Night Toronto",
                        "EventRsvp":3,
                        "Date":0],
                      ["Group":"Mobile Growth Toronto",
                        "EventTitle":"Mobile Growth Toronto - December Meetup",
                        "EventRsvp":5,
                        "Date":"2018-12-01"],
                      ["Group":"Lighthouse Labs",
                        "EventTitle":"Hack & Tell: Round 9",
                        "EventRsvp":2,
                        "Date":0],
                      ["Group":"Singles in Toronto!",
                        "EventTitle":"20 Questions 'The Fun Version' (Ages 25-39) - Meet with Singles & See who you like!",
                        "EventRsvp":2,
                        "Date":0],
                      ["Group":"The Toronto Area Gamers (TAG)",
                        "EventTitle":"Fan Expo Canada 2016",
                        "EventRsvp":1,
                        "Date":0],
                      ["Group":"Adult ART Attack",
                        "EventTitle":"Adult ART Attack - Painting with a twist!",
                        "EventRsvp":2,
                        "Date":0],
                      ["Group":"Saturday Night For Singles",
                        "EventTitle":"The Thursday Night Pool, Party & Patio Bash! *Free Night of Dancing*",
                        "EventRsvp":2,
                        "Date":0],
                      ["Group":"Toronto Short Trippers",
                        "EventTitle":"Beautiful Bruce Peninsula & Flowerpot Island (Day Trip from Toronto)",
                        "EventRsvp":1,
                        "Date":"2018-08-27"]]
        
        
        for event in events {
            
//            let date = dateFormatter.dateFromString(event["Date"]!)
            
            let someEvent = Event(eventId: "", title: "", time: 0, yesRsvpCount: 0, eventStatus: "")
            
                someEvent.title = event["EventTitle"] as? String
                someEvent.yesRsvpCount = event["EventRsvp"] as! NSInteger
            
            //let someEvent = Event(title: event["EventTitle"]!, location: event["EventLocation"]!, date: date!, group: event["Group"]!)
            
            eventList.append(someEvent)
            
        }
        
        return eventList
    }
    
    class func grabEventsFromAPI(handler:(events: [Event])->()){
        
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
    
    func grabMembersFromAPI(handler:(members:[Member])->()) {
        
        var membersArray:[Member] = []
        let api = APIController()
        var memberImageData: NSData?
        
        print(self.eventId)
        
        api.getRSVPs(self.eventId, token: AppDelegate.token!, handler: { (membersDict: NSDictionary) in
            if let memberResults = membersDict["results"] as? [[String:AnyObject]] {
                //go through every member
                for memberObject in memberResults {
                    if let memberPhoto = memberObject["member_photo"] as? NSDictionary{
                        //get photo of the member
                        let memberPhotoLink = memberPhoto["thumb_link"] as! String
                        let url: NSURL = NSURL(string: memberPhotoLink as String)!
                        memberImageData = NSData(contentsOfURL: url)! as NSData
                        
                    }
                    
                    if let member = memberObject["member"] as? NSDictionary {
                        //get all details under every member
                        let memberId = member["member_id"]!.stringValue
                        let memberName = member["name"] as! String
                        //print(memberName, memberId)
                        
                        //create member object
                        let member = Member.init(memberId: memberId, memberName: memberName, memberImage: memberImageData!)
                        membersArray.append(member)
                        
                        
                    }
                                            
                }
            }
            handler(members: membersArray)
        })
    }
    
    
    
    
    
    func saveContactListArray() {  // This is contacts Tableview datasource
    
    
    }
    
    func saveToPhone() {
        
        let graph = Graph()
        graph.async { (success: Bool, error: NSError?) in
            
            if success {
                
                print("Success: \(success)")
                
            } else {
                
                print("Error: \(error)")
                
            }
            
        }
        
    }
    
     func saveNewContact() {
    
        
        
    }
    
    func updateContact() {
        
        
    
    }
    
    func updateProperty() {
    
    
    
    }
    
    func updateContactPhoto() {
    
    
    
    }
    
    func deleteContact(user:User) {
        
        let users:Array<Entity> = graph.searchForEntity(properties: [(key: "name", value: user.name)])
        
        if !users.isEmpty {
            
            let user = users.first
            
            user?.delete()
            
            saveToPhone()  //  insert save to context here
            
        } else {
            
            print("User does not exist")

        }
    
    }
    
    class func getDateFromMilliseconds(ms: NSNumber) -> NSDate {
        
        let offset = -14400000 // 4 hours earlier == EST
        let msec = ms.integerValue + offset
        let date  = NSDate(timeIntervalSince1970:Double(msec) / 1000.0)
        return date
        
    }
    
}
// Eugene

/*
 EventsViewController:
 <[MyMeetup: GroupName, EventTitle, Number of participants, event date]>
 (sorted by event date)
*/

/*
 EventsDetailViewController:
 <[EventTitle: Participant, ParticipantTitle, inContactList]>
 (sorted alphabetically by participant first name)
 */



// Rene

/*
User profile:
[photo, name, title, company, email, password, phone, github, linkedin, meetup account]
 */


/*
ContactsViewController:
 <[Participant: ParticipantTitle, Company, Email, phone, github, linkedin]>
*/

