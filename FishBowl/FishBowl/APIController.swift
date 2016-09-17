//
//  APIController.swift
//  FishBowl
//
//  Created by Yevhen Kim on 2016-08-12.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import Foundation
import OAuthSwift
import Firebase

class APIController: UIViewController {
    
    var jsonUser: NSDictionary!
    var jsonRsvp: NSArray!
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
        let webVC: WebViewController = WebViewController()
        oauthswift.authorize_url_handler = webVC
        
        //authorization callback
        oauthswift.authorizeWithCallbackURL(
            URL(string: "FishBowlKomrad://FishBowlKomrad/Meetup")!,
            scope: "",state: "",
            success: { credential, response, parameters in
                AppDelegate.token = credential.oauth_token
                FIRAuth.auth()?.signIn(withCustomToken: AppDelegate.token!, completion: {
                    (user, error) in
                    print(user)
                })
            },
            failure: { error in
                print(error.localizedDescription)
                
            }
        )
    }
    
    //MARK - Get Requests for
    
    func getUserDetails(_ token: String, handler:@escaping (_ userDict: NSDictionary)->()){
        
        self.oauthswift.client.get("https://api.meetup.com/2/member/self?access_token=\(token)",
            success:
            {
                        data, response in
                        
                        //parse data to json
                        do {
                            self.jsonUser = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                            handler(userDict: self.jsonUser)
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
    func getEvents(_ token: String, handler:@escaping (_ eventsDict: NSArray)->()) {
        oauthswift.client.get("https://api.meetup.com/self/events?access_token=\(token)&page=200",
            success: {
                        data, response in
                        //let dataString = NSString(data:data, encoding: NSUTF8StringEncoding)
                        //print(dataString)
                        
                        //parse data to json
                        do {
                            self.jsonRsvp = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                            handler(eventsDict: self.jsonRsvp)

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
    //call this method when the user tap on event cell
    func getRSVPs(_ eventId: String, token: String, handler:@escaping (_ membersDict: NSDictionary)->()) {
        oauthswift.client.get("https://api.meetup.com/2/rsvps?&access_token=\(token)&event_id=\(eventId)&page=500",
            success: {
                        data, response in
                        //let dataString = NSString(data:data, encoding: NSUTF8StringEncoding)
                        do {
                            self.jsonMembers = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                            handler(membersDict: self.jsonMembers)
                            
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

    
//    func getRefreshToken() {
//        oauthswift.client.get("https://secure.meetup.com/oauth2/access", success: {
//            
//            },
//            failure: {
//        })
//    }
    
//    func refreshToken() {
//        oauthswift.client.get("https://secure.meetup.com/oauth2/access",
//                              success: {
//                                data, response in
//                                print("\(data).")
//            },
//                              failure: { error in
//                                if error.isExpireToken {
//                                    // reconnect 
//                                }
//        })
//        
//        
//            
//            var isExpireToken: Bool {
//                if self.code == 401 {
//                    // if error.localizedDescription.rangeOfString("a string like token invalid") != nil
//                    // or parse headers
//                    if let reponseHeaders = error.userInfo["Response-Headers"] as? [String:String],
//                        authenticateHeader = reponseHeaders["WWW-Authenticate"] ?? reponseHeaders["Www-Authenticate"] {
//                        // you can split authenticateHeader to find "error"
//                        let headerDictionary = authenticateHeader.headerDictionary
//                        if let error = headerDictionary["error"] where error == "invalid_token" {
//                            return true
//                        }
//                    }
//                }
//                return false
//            }
//            
//        
//    }
    
    
}
