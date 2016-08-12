//
//  api.swift
//  FishBowl
//
//  Created by Yevhen Kim on 2016-08-11.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import Foundation
import UIKit
import OAuthSwift
import Graph

class ApiController: UIViewController {
    
    var jsonDict: NSDictionary!
    var jsonRsvp: NSDictionary!
    var jsonMembers: NSDictionary!
    
    var jsonManager = DataManager()
    
    var userIds = [String]()
    var memberIds = [String]()
    var events = NSMutableArray()
    
    var userImageData: NSData?
    var memberImageData: NSData?
    
    var eventItem: Event!
    var user: User!
    var member: Member!
    
    //client configuration
    let oauthswift = OAuth2Swift(
        consumerKey:    "kgl0pnvun5cgu5bjk69j9no98",
        consumerSecret: "r0u20f0ajs3cp3gkr520q22irv",
        authorizeUrl:   "https://secure.meetup.com/oauth2/authorize",
        accessTokenUrl: "https://secure.meetup.com/oauth2/access",
        responseType:   "token"
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK - MeetUP Auth

    func doAuthMeetup() {
        print("authorizing")
        //login thru safari and go back to the view controller
        if #available(iOS 9.0, *) {
           let eventsVC = EventsViewController()
            self.presentViewController(eventsVC, animated: false, completion: {
                self.oauthswift.authorize_url_handler = SafariURLHandler(viewController:eventsVC)
            })
//           oauthswift.authorize_url_handler = SafariURLHandler(viewController:eventsVC)
        }
//        else {
           // oauthswift.authorize_url_handler = WebViewController()
        //}
        
        //authorization callback
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "CardBowlTest://CardBowlTest/Meetup")!,
            scope: "",state: "",
            success: { credential, response, parameters in
                //print(credential.oauth_token)
                //print(parameters)
                //call getUserDetails
                self.getUserDetails()
                
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
        
        
    }
    
    //MARK - Get Requests for
    
    func getUserDetails() {
        self.oauthswift.client.get("https://api.meetup.com/2/member/self",
                                   success: {
                                    data, response in
                                    //let dataString = NSString(data:data, encoding: NSUTF8StringEncoding)
                                    //print(dataString)
                                    
                                    //parse data to json
                                    do {
                                        self.jsonDict = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                                        
                                        //get all necessary data from json
                                        let userId = self.jsonDict["id"]!.stringValue
                                        let userName = self.jsonDict["name"] as! String
                                        let userBio = self.jsonDict["bio"] as! String
                                        
                                        //get the thumbnail image of user
                                        if let photo = self.jsonDict["photo"] as? [String: AnyObject] {
                                            let photoLink = photo["thumb_link"] as! NSString
                                            let url: NSURL = NSURL(string: photoLink as String)!
                                            self.userImageData = NSData(contentsOfURL: url)!
                                            
                                        }
                                        //safe the user id in an array
                                        self.userIds.append(userId)
                                        //create a user object
                                        self.user = User.init(userId: userId, name: userName, bio: userBio, image: self.userImageData!)
                                        //check if the user id is NOT in the array of Ids
                                        if !self.userIds.contains(userId) {
                                            
                                            //save this data to DB or to local storage
//                                            self.jsonManager.createUserWithName(self.user.userName, bio: self.user.userBio, userId: self.user.userId)
                                        }
                                        
                                        //call getEvents here
                                        self.getEvents()
                                    }
                                    catch let error as NSError{
                                        print(error.localizedDescription)
                                    }
            },
           failure: {
            error in
            print(error)
        })
        
    }
    
    //get all events under signed in user
    func getEvents() {
        //print(self.user.userId)
        oauthswift.client.get("https://api.meetup.com/2/events?&sign=true&photo-host=public&fields=self&member_id=\(self.user.userId)&page=20",
                              success: {
                                data, response in
                                //let dataString = NSString(data:data, encoding: NSUTF8StringEncoding)
                                //print(dataString)
                                
                                //parse data to json
                                do {
                                    self.jsonRsvp = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
                                    
                                    //unwrap jsonRsvp
                                    if let results = self.jsonRsvp["results"] as? [[String: AnyObject]] {
                                        for result in results {
                                            //get the results of every event
                                            let eventId = result["id"] as! String
                                            let eventName = result["name"] as! String
                                            let eventTime = result["time"] as! NSNumber
                                            let eventYesRsvpCount = result["yes_rsvp_count"] as! NSInteger
                                            let eventStatus = result["status"] as! String
                                            
                                            //create an event object
                                            self.eventItem = Event.init(eventId:eventId, title: eventName, time:eventTime, yesRsvpCount: eventYesRsvpCount, eventStatus: eventStatus)
                                            //print(self.eventItem)
                                            
                                            //now add eventItem object to events array
                                            self.events.addObject(self.eventItem)
                                            //print(self.eventItem.eventId)
                                            //print(self.eventItem.eventName)
                                            //call getRSVPs
                                            self.getRSVPs()
                                            
                                        }
                                    }
                                    
                                }
                                catch let error as NSError{
                                    print(error.localizedDescription)
                                }
                                
            },
              failure: {
                error in
                print(error)
        })
    }
    
    
    //get RSVPs
    func getRSVPs() {
        oauthswift.client.get("https://api.meetup.com/2/rsvps?&sign=true&photo-host=public&event_id=\(self.eventItem.eventId)&page=500",
                              success: {
                                data, response in
                                //let dataString = NSString(data:data, encoding: NSUTF8StringEncoding)
                                //print(dataString)
                                //print("*********************************")
                                do {
                                    self.jsonMembers = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
                                    //unwrap jsonMembers
                                    if let memberResults = self.jsonMembers["results"] as? [[String:AnyObject]] {
                                        //go through every member
                                        for memberObject in memberResults {
                                            if let memberPhoto = memberObject["member_photo"] as? NSDictionary{
                                                //get photo of the member
                                                let memberPhotoLink = memberPhoto["thumb_link"] as! String
                                                let url: NSURL = NSURL(string: memberPhotoLink as String)!
                                                self.memberImageData = NSData(contentsOfURL: url)!
                                                
                                            }
                                            
                                            if let member = memberObject["member"] as? NSDictionary {
                                                //get all details under every member
                                                let memberId = member["member_id"]!.stringValue
                                                let memberName = member["name"] as! String
                                                self.memberIds.append(memberId)
                                                //print(memberName, memberId)
                                                
                                                //create member object
                                                self.member = Member.init(memberId: memberId, memberName: memberName, memberImage: self.memberImageData!)
                                                //self.getMembersInEvents()
                                                
                                            }
                                            
                                        }
                                    }
                                }
                                catch {
                                    print(error)
                                }
                                
            },
              failure: {
                error in
                print(error)
        })
        
    }
    
    //get every member data in every event
    func getMembersInEvents() {
        oauthswift.client.get("https://api.meetup.com/2/member/39478612?&sign=true&photo-host=public&page=20x",
                              success: {
                                data, response in
                                print("******************************")
                                let dataString = NSString(data:data, encoding: NSUTF8StringEncoding)
                                print("******************************")
                                print(dataString)
            },
                              failure: {
                                error in
                                fatalError()
                                //print(error)
        })
    }

}