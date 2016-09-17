//  ParticipantsModel.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io . All rights reserved.

import Foundation
import UIKit

open class ParticipantsModel: NSObject {
    static let setParticipants = "didSetParticipants"
    var members: [Member] = [] {
        didSet {
            // do this on the main thread
            DispatchQueue.main.async(execute: {
                let notification = Notification(name: Notification.Name(rawValue: ParticipantsModel.setParticipants), object: self)
                NotificationCenter.default.post(notification)
            })
        }
    }
    
    /*
    @name   required initWithCoder
    */
    open class func sectionsCount() -> Int { return 1 }
    
    /*
    @name   required initWithCoder
    */

    func getMembers() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dataManager = appDelegate.dataManager
        dataManager!.grabMembersFromAPI { (members) in
            self.members = members
        }
    }
}
