//
//  DataManager.swift
//  FishBowl
//
//  Created by Rene Mojica, Yevhen Kim on 2016-08-10.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import Foundation
import UIKit
import OAuthSwift
import Graph


class DataManager: NSObject {
    
    let graph = Graph()
    var eventId: String!
    
    class func createUserDummyData() -> Array<User> {
        
        var userList = Array<User>()
        
        let users : [Dictionary<String,AnyObject>] = [["name":"Justin Trudeau",
            "email":"justin.trudeau@parl.gc.ca",
            "phone": "18885696898",
            "github":"",
            "linkedin":"https://ca.linkedin.com/in/justintrudeau",
            "title":"Prime Minister, Canada",
            "company": "",
            "image": UIImagePNGRepresentation(UIImage(named:"justintrudeau")!)!],
                                                      
            ["name":"Bill Gates", "email":"billg@microsoft.com.",
            "phone":"18885696898",
            "github":"",
            "linkedin":"https://www.linkedin.com/in/williamhgates",
            "title":"Technology Advisor",
            "company": "Microsoft",
            "image":UIImagePNGRepresentation(UIImage(named:"billgates")!)!],
            
            ["name":"Larry Page",
            "email":"larry@google.com",
            "phone":"18885696898",
            "github":"",
            "linkedin":"https://www.linkedin.com/in/tlytle",
            "title":"CEO",
            "company": "Alphabet Inc",
            "image": UIImagePNGRepresentation(UIImage(named:"larrypage")!)!],
            
            ["name":"Mark Zuckerberg",
            "email":"zuck@fb.com",
            "phone":"18885696898",
            "github":"",
            "linkedin":"",
            "title":"Chairman and CEO, Facebook",
            "company": "",
            "image": UIImagePNGRepresentation(UIImage(named:"markzuckerberg")!)!],
            ["name":"Marissa Mayer",
            "email":"marissa.mayer@yahoo-inc.com",
            "phone":"18885696898",
            "github":"",
            "linkedin":"https://www.linkedin.com/in/marissamayer",
            "title":"CEO, Yahoo!",
            "company": "",
            "image": UIImagePNGRepresentation(UIImage(named:"marissamayer")!)!]]
        
          
        
        for user in users {
            
            let name = user["name"] as! String
            let email = user["email"] as! String
            let phone = user["phone"] as! String
            let github = user["github"] as! String
            let linkedin = user["linkedin"] as! String
            let title = user["title"] as! String
            let company = user["company"] as? String
            let image = user["image"] as? NSData
            
            let someUser = User(userId: "", name: name)
           
            
            someUser.bio = title
            someUser.email = email
            someUser.phone = phone
            someUser.image = image
            someUser.linkedin = linkedin
            someUser.github = github
            someUser.company = company
            
            userList.append(someUser)
            
        }
        
        return userList
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
        
        
        print(self.eventId)
        
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
    
    
    func saveCurrentUser(name:String, title:String, company:String, email:String, phone: NSNumber?, github:String, linkedin:String, image:NSData) {
        
        //check if currentUser exists
        let users = graph.searchForEntity(types: ["CurrentUser"])
        if users.count == 0 {
        
        let user: Entity = Entity(type: "CurrentUser")
        user["name"] = name
        user["title"] = title
        user["company"] = company
        user["email"] = email
        user["phone"] = phone
        user["github"] = github
        user["linkedin"] = linkedin
        user["image"] = image
        
        } else {
            
         let users = graph.searchForEntity(types: ["CurrentUser"])
         let user = users.first! as Entity
            
            user["name"] = name
            user["title"] = title
            user["company"] = company
            user["email"] = email
            user["phone"] = phone
            user["github"] = github
            user["linkedin"] = linkedin
            user["image"] = image

        
        }
        
        saveToPhone()

    }
    

    func addContact(userID: String, name:String, title:String?, company:String?, email:String?, phone: String?, github:String?, linkedin:String?, image:NSData?) {
    
        let contact: Entity = Entity(type: "Contact")
        
        contact["userID"] = userID
        contact["name"] = name
        contact["title"] = title
        contact["company"] = company
        contact["email"] = email
        contact["phone"] = phone
        contact["github"] = github
        contact["linkedin"] = linkedin
        contact["image"] = image
        
        saveToPhone()
    

    }
    
    class func getCurrentUser() -> Array<Entity> {
        
        let graph = Graph()
        let users = graph.searchForEntity(types: ["CurrentUser"])
        
        return users
        
    }
    
    class func getContacts() -> Array<User> {
        
        let graph = Graph()
        var contactList = Array<User>()
        
        let contacts = graph.searchForEntity(types: ["Contact"])
        
        if contacts.count > 0 {
        
            for contact in contacts {
        
                let id = contact["userID"] as! String
                let name = contact["name"] as! String
                let title = "" //contact["title"] as! String
                let company = "" //contact["company"] as! String
                let email = "" //"contact["email"] as! String
                let phone = "" //contact["phone"] as! String
                let github = "" //contact["github"] as! String
                let linkedin = "" //contact["linkedin"] as! String
                let image = contact["image"] as! NSData
            
                let user = User(userId: id, name: name)
                user.image = image
                user.bio = title
                user.email = email
                user.phone = phone
                user.github = github
                user.linkedin = linkedin
                user.company = company
            
                contactList.append(user)
            }
        }

        return contactList
    
    }
    
    
    class func getMemberIDsFromContacts() -> Set<String> {
        let graph = Graph()
        var savedContacts = Set<String>()
        let contacts = graph.searchForEntity(types:["Contact"])
        if contacts.count == 0 {
            
            return savedContacts
            
        } else {
        
            for contact in contacts {
            
                savedContacts.insert(contact["userID"] as! String)
            
            }
            
            return savedContacts
        
        }
        
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
        
        let msec = ms.integerValue
        let date  = NSDate(timeIntervalSince1970:Double(msec) / 1000.0)
        return date
        
    }
    
    class func removeNonNumericCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("1234567890".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }

    
}


