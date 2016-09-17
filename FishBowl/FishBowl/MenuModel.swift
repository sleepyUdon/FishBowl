//  MenuModel.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-08.
//  Edited by Yevhen Kim
//  Copyright © 2016 Komrad.io . All rights reserved.

import Foundation
import UIKit

open class MenuModel: NSObject {
    static let setEventsName = "didSetEvents"
    var events: [Event] = [] {
        didSet {
            let notification = Notification(name: Notification.Name(rawValue: MenuModel.setEventsName), object: self)
            NotificationCenter.default.post(notification)
        }
    }
    
    /*
    @name   required initWithCoder
    */
    open class func sectionsCount() -> Int { return 1 }
    
    /*
    @name   required initWithCoder
    */

    func getEvents() {
        DataManager.grabEventsFromAPI { (events) in
            self.events = events
            
        }
    }
}
