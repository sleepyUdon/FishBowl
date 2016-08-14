

import Foundation
import UIKit

public class MenuModel: NSObject {
    
    
    /*
    @name   required initWithCoder
    */
    public class func sectionsCount() -> Int { return 1 }
    
    /*
    @name   required initWithCoder
    */

    func getEvents() -> [Event] {
        
        let dummyEvents = DataManager.createEventDummyData()
        let eventsFromAPI = DataManager.grabEventsFromAPI()
        
        if eventsFromAPI.isEmpty {
            
            let events = dummyEvents
            return events
            
        } else {
            
            let events = dummyEvents + eventsFromAPI
            return events
            
        }
    }
}