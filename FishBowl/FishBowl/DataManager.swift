//
//  DataManager.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-09.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import Foundation
import UIKit

class DataManager: NSObject {

    var userList = [User]()
    var eventList = [Event]()
    
    func createUserDummyData() -> [User] {
        
        let users : [Dictionary<String,AnyObject>] = [["name":"Justin Trudeau",
            "email":"justin.trudeau@parl.gc.ca",
            "phone": 6139924211,
            "github":"",
            "linkedin":"https://ca.linkedin.com/in/justintrudeau",
            "title":"Prime Minister",
            "company":"Canada",
            "image": UIImagePNGRepresentation(UIImage(named:"justintrudeau")!)!],
            ["name":"Bill Gates", "email":"billg@microsoft.com.",
            "phone":2067093100,
            "github":"",
            "linkedin":"https://www.linkedin.com/in/williamhgates",
            "title":"Technology Advisor",
            "company":"Microsoft",
            "image":UIImagePNGRepresentation(UIImage(named:"billgates")!)!],
            ["name":"Larry Page",
            "email":"larry@google.com",
            "phone":6502141722,
            "github":"",
            "linkedin":"https://www.linkedin.com/in/tlytle",
            "title":"CEO",
            "company":"Alphabet Inc.",
            "image": UIImagePNGRepresentation(UIImage(named:"larrypage")!)!],
            ["name":"Mark Zuckerberg",
            "email":"zuck@fb.com",
            "phone":16505434800,
            "github":"",
            "linkedin":"",
            "title":"Chairman and CEO",
            "company":"Facebook",
            "image": UIImagePNGRepresentation(UIImage(named:"markzuckerberg")!)!],
            ["name":"Marissa Mayer",
            "email":"marissa.mayer@yahoo-inc.com",
            "phone":4083493300,
            "github":"",
            "linkedin":"https://www.linkedin.com/in/marissamayer",
            "title":"CEO",
            "company":"Yahoo!",
            "image": UIImagePNGRepresentation(UIImage(named:"marissamayer")!)!]]
        
        for user in users {
            
            let name = user["name"] as! String
            let email = user["email"] as! String
            let phone = user["phone"] as! NSNumber
            let github = user["github"] as! String
            let linkedin = user["linkedin"] as! String
            let title = user["title"] as! String
            let image = user["image"] as? NSData
            let company = user["company"] as! String
            
            
            
            //            let someUser:User = User(name: user["name"], email: user["email"], image: nil, phone: user["phone"], github: user["github"], linkedin: user["linkedin"], title: user["title"])
            
            let someUser = User(name: name, email: email, image: image!, phone: phone, github: github, linkedin: linkedin, title: title, company:company)
            
            self.userList.append(someUser)
            
        }
        
        return userList
    }

    func createEventDummyData() -> [Event]{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let events = [["Group":"DevHub",
                        "EventTitle":"NSCoder Night Toronto",
                        "EventLocation":"",
                        "Date":"2016-08-30"],
                      ["Group":"Mobile Growth Toronto",
                        "EventTitle":"Mobile Growth Toronto - December Meetup",
                        "EventLocation":"",
                        "Date":"2016-12-01"],
                      ["Group":"Lighthouse Labs",
                        "EventTitle":"Hack & Tell: Round 9",
                        "EventLocation":"",
                        "Date":"2016-10-11"],
                      ["Group":"Singles in Toronto!",
                        "EventTitle":"20 Questions 'The Fun Version' (Ages 25-39) - Meet with Singles & See who you like!",
                        "EventLocation":"",
                        "Date":"2016-08-13"],
                      ["Group":"The Toronto Area Gamers (TAG)",
                        "EventTitle":"Fan Expo Canada 2016",
                        "EventLocation":"",
                        "Date":"2016-09-01"],
                      ["Group":"Adult ART Attack",
                        "EventTitle":"Adult ART Attack - Painting with a twist!",
                        "EventLocation":"",
                        "Date":"2016-09-02"],
                      ["Group":"Saturday Night For Singles",
                        "EventTitle":"The Thursday Night Pool, Party & Patio Bash! *Free Night of Dancing*",
                        "EventLocation":"",
                        "Date":"2016-08-25"],
                      ["Group":"Toronto Short Trippers",
                        "EventTitle":"Beautiful Bruce Peninsula & Flowerpot Island (Day Trip from Toronto)",
                        "EventLocation":"",
                        "Date":"2016-08-27"]]
        
        
        for event in events {
            
            let date = dateFormatter.dateFromString(event["Date"]!)
            
            let someEvent = Event(title: event["EventTitle"]!, location: event["EventLocation"]!, date: date!, group: event["Group"]!)
            
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



