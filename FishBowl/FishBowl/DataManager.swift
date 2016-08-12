//
//  DataManager.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-09.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import Foundation
import UIKit
import OAuthSwift

class DataManager: NSObject {
    
    func createUserDummyData() -> [User] {
        
        var userList = [User]()
        
        let users : [Dictionary<String,AnyObject>] = [["name":"Justin Trudeau",
            "email":"justin.trudeau@parl.gc.ca",
            "phone": 6139924211,
            "github":"",
            "linkedin":"https://ca.linkedin.com/in/justintrudeau",
            "title":"Prime Minister, Canada",
            "image": UIImagePNGRepresentation(UIImage(named:"justintrudeau")!)!],
            ["name":"Bill Gates", "email":"billg@microsoft.com.",
            "phone":2067093100,
            "github":"",
            "linkedin":"https://www.linkedin.com/in/williamhgates",
            "title":"Technology Advisor, Microsoft",
            "image":UIImagePNGRepresentation(UIImage(named:"billgates")!)!],
            ["name":"Larry Page",
            "email":"larry@google.com",
            "phone":6502141722,
            "github":"",
            "linkedin":"https://www.linkedin.com/in/tlytle",
            "title":"CEO, Alphabet Inc",
            "image": UIImagePNGRepresentation(UIImage(named:"larrypage")!)!],
            ["name":"Mark Zuckerberg",
            "email":"zuck@fb.com",
            "phone":16505434800,
            "github":"",
            "linkedin":"",
            "title":"Chairman and CEO, Facebook",
            "image": UIImagePNGRepresentation(UIImage(named:"markzuckerberg")!)!],
            ["name":"Marissa Mayer",
            "email":"marissa.mayer@yahoo-inc.com",
            "phone":4083493300,
            "github":"",
            "linkedin":"https://www.linkedin.com/in/marissamayer",
            "title":"CEO, Yahoo!",
            "image": UIImagePNGRepresentation(UIImage(named:"marissamayer")!)!]]
        
        for user in users {
            
            let name = user["name"] as! String
            let email = user["email"] as! String
            let phone = user["phone"] as! NSNumber
            let github = user["github"] as! String
            let linkedin = user["linkedin"] as! String
            let title = user["title"] as! String
            let image = user["image"] as? NSData
            
//            var userId: String
//            var name: String
//            var bio: String
//            var email: String?
//            var image: NSData?
//            var phone: NSNumber?
//            var github: String?
//            var linkedin: String?
            
            
            //            let someUser:User = User(name: user["name"], email: user["email"], image: nil, phone: user["phone"], github: user["github"], linkedin: user["linkedin"], title: user["title"])
            
               //let someUser = Member.init(memberId: <#T##String#>, memberName: <#T##String#>, memberImage: <#T##NSData#>)
            
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

    func createEventDummyData() -> [Event]{
        
        var eventList = [Event]()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let events = [["Group":"DevHub",
                        "EventTitle":"NSCoder Night Toronto",
                        "EventRsvp":3,
                        "Date":"2018-08-30"],
                      ["Group":"Mobile Growth Toronto",
                        "EventTitle":"Mobile Growth Toronto - December Meetup",
                        "EventRsvp":5,
                        "Date":"2018-12-01"],
                      ["Group":"Lighthouse Labs",
                        "EventTitle":"Hack & Tell: Round 9",
                        "EventRsvp":2,
                        "Date":"2018-10-11"],
                      ["Group":"Singles in Toronto!",
                        "EventTitle":"20 Questions 'The Fun Version' (Ages 25-39) - Meet with Singles & See who you like!",
                        "EventRsvp":2,
                        "Date":"2018-08-13"],
                      ["Group":"The Toronto Area Gamers (TAG)",
                        "EventTitle":"Fan Expo Canada 2016",
                        "EventRsvp":1,
                        "Date":"2018-09-01"],
                      ["Group":"Adult ART Attack",
                        "EventTitle":"Adult ART Attack - Painting with a twist!",
                        "EventRsvp":2,
                        "Date":"2018-09-02"],
                      ["Group":"Saturday Night For Singles",
                        "EventTitle":"The Thursday Night Pool, Party & Patio Bash! *Free Night of Dancing*",
                        "EventRsvp":2,
                        "Date":"2018-08-25"],
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



