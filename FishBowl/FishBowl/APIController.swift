//
//  APIController.swift
//  FishBowl
//
//  Created by Yevhen Kim on 2016-08-12.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import Foundation
import OAuthSwift

class APIController: UIViewController {
    
    var jsonDict: NSDictionary!
    var jsonRsvp: NSDictionary!
    var jsonMembers: NSDictionary!
    
    
    //client configuration
    let oauthswift = OAuth2Swift(
        consumerKey:    "kgl0pnvun5cgu5bjk69j9no98",
        consumerSecret: "r0u20f0ajs3cp3gkr520q22irv",
        authorizeUrl:   "https://secure.meetup.com/oauth2/authorize",
        accessTokenUrl: "https://secure.meetup.com/oauth2/access",
        responseType:   "token"
    )
    
    // MARK - MeetUP Auth
    
    func doAuthMeetup() {
        print("authorizing")
        //login thru safari and go back to the view controller
        if #available(iOS 9.0, *) {
            UIApplication.sharedApplication().openURL( NSURL(string: "CardBowlTest://CardBowlTest/Meetup")!)
        }

        
        //authorization callback
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "CardBowlTest://CardBowlTest/Meetup")!,
            scope: "",state: "",
            success: { credential, response, parameters in
                print(credential.oauth_token)
                //print(parameters)
                AppDelegate.token = credential.oauth_token
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
        
        
    }
    
    //MARK - Get Requests for
    
    func getUserDetails(token: String) -> NSDictionary {
        self.oauthswift.client.get("https://api.meetup.com/2/member/self?access_token=\(token)",
            success:
            {
                        data, response in
                        
                        //parse data to json
                        do {
                            self.jsonDict = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                        }
                        catch let error as NSError{
                            print(error.localizedDescription)
                        }
            },
              failure: {
                        error in
                        print(error)
        })
        return self.jsonDict
        
    }
    
    //get all events under signed in user
    func getEvents(token: String) -> NSDictionary {
        //print(self.user.userId)
        oauthswift.client.get("https://api.meetup.com/events?access_token=\(token)&page=20",
            success: {
                        data, response in
                        //let dataString = NSString(data:data, encoding: NSUTF8StringEncoding)
                        //print(dataString)
                        
                        //parse data to json
                        do {
                            self.jsonRsvp = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary

                        }
                        catch let error as NSError{
                            print(error.localizedDescription)
                        }
                
            },
              failure: {
                        error in
                        print(error)
        })
        return self.jsonRsvp
    }

    //get RSVPs
    //call this method when the user tap on event cell
    func getRSVPs(eventId: String) {
        oauthswift.client.get("https://api.meetup.com/2/rsvps?&sign=true&photo-host=public&event_id=\(eventId)&page=500",
            success: {
                        data, response in
                        //let dataString = NSString(data:data, encoding: NSUTF8StringEncoding)
                        //print(dataString)
                        //print("*********************************")
                        do {
                            self.jsonMembers = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
                            
                            
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
    //call this method when the user tap on participant cell
    func getMembersInEvents() {
        oauthswift.client.get("https://api.meetup.com/2/member/39478612?&sign=true&photo-host=public&page=20x",
            success: {
                        data, response in
//                        print("******************************")
//                        let dataString = NSString(data:data, encoding: NSUTF8StringEncoding)
//                        print("******************************")
//                        print(dataString)
                
                        do {
                            self.jsonMembers = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
                           
                        }
                        catch {
                            print(error)
                        }
            },
              failure: {
                        error in
                        fatalError()
                        //print(error)
        })
    }

    
    

    
    

    
}