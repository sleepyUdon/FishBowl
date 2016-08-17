

import Foundation
import UIKit

public class MenuModel: NSObject {
    static let setEventsName = "didSetEvents"
    var events: [Event] = [] {
        didSet {
            let notification = NSNotification(name: MenuModel.setEventsName, object: self)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    
    /*
    @name   required initWithCoder
    */
    public class func sectionsCount() -> Int { return 1 }
    
    /*
    @name   required initWithCoder
    */

    func getEvents() {
        
        DataManager.grabEventsFromAPI { (events) in
            self.events = events
            
        }  
        
    }
}