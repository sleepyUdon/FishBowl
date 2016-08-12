

import Foundation
import UIKit

public class MenuModel: NSObject {
    
    
    /*
    @name   required initWithCoder
    */
    public class func sectionsCount() -> Int { return 1 }

    func getEvents() -> Array<Event> {
        
        let events = DataManager().createEventDummyData()
        
        return events
        
    }
    
}