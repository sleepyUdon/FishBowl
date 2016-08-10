//
//  DataManager.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-09.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import Foundation

class DataManager: NSObject {

    
    
    var users = ["user":[["name":"Justin Trudeau",
        "email":"justin.trudeau@parl.gc.ca",
        "phone":"613-992-4211",
        "github":"",
        "linkedin":"https://ca.linkedin.com/in/justintrudeau"],
        ["name":"Bill Gates",
            "email":"billg@microsoft.com.",
            "phone":"(206) 709-3100",
            "github":"",
            "linkedin":"https://www.linkedin.com/in/williamhgates"],
        ["name":"Larry Page",
            "email":"larry@google.com",
            "phone":"650-214-1722",
            "github":"",
            "linkedin":"https://www.linkedin.com/in/tlytle"],
        ["name":"Mark Zuckerberg",
            "email":"zuck@fb.com",
            "phone":"+1 650 543 4800",
            "github":"",
            "linkedin":""],
        ["name":"Marissa Mayer",
            "email":"marissa.mayer@yahoo-inc.com",
            "phone":"408 349 3300",
            "github":"",
            "linkedin":"https://www.linkedin.com/in/marissamayer"]]]
    
    
    var events = [["Group":"DevHub",
        "EventTitle":"NSCoder Night Toronto",
        "Date":"Aug 30"],
                  ["Group":"Mobile Growth Toronto",
                    "EventTitle":"Mobile Growth Toronto - December Meetup",
                    "Date":"Dec 1"],
                  ["Group":"Lighthouse Labs",
                    "EventTitle":"Hack & Tell: Round 9",
                    "Date":"Oct 11"],
                  ["Group":"Singles in Toronto!",
                    "EventTitle":"20 Questions 'The Fun Version' (Ages 25-39) - Meet with Singles & See who you like!",
                    "Date":"August 13, 2016 "],
                  ["Group":"The Toronto Area Gamers (TAG)",
                    "EventTitle":"Fan Expo Canada 2016",
                    "Date":"Sep 1"],
                  ["Group":"Adult ART Attack",
                    "EventTitle":"Adult ART Attack - Painting with a twist!",
                    "Date":"September 2, 2016"],
                  ["Group":"Saturday Night For Singles",
                    "EventTitle":"The Thursday Night Pool, Party & Patio Bash! *Free Night of Dancing*",
                    "Date":"August 25"],
                  ["Group":"Toronto Short Trippers",
                    "EventTitle":"Beautiful Bruce Peninsula & Flowerpot Island (Day Trip from Toronto)",
                    "Date":"Aug 27"]]
    
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



