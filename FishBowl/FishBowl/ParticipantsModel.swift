//  ParticipantsModel.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io . All rights reserved.

import Foundation
import UIKit

public class ParticipantsModel: NSObject {
    static let setParticipants = "didSetParticipants"
    var members: [Member] = [] {
        didSet {
            // do this on the main thread
            dispatch_async(dispatch_get_main_queue(), {
                let notification = NSNotification(name: ParticipantsModel.setParticipants, object: self)
                NSNotificationCenter.defaultCenter().postNotification(notification)
            })
        }
    }
    
    /*
    @name   required initWithCoder
    */
    public class func sectionsCount() -> Int { return 1 }
    
    /*
    @name   required initWithCoder
    */

    func getMembers() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let dataManager = appDelegate.dataManager
        dataManager!.grabMembersFromAPI { (members) in
            self.members = members
        }
    }
}