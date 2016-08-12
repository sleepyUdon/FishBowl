

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
    
    
    var events = ["Event1":["Group":"Devhub","EventTitle":"Lighhouse Labs Demo Day","Date":"Monday","Participants" : "Viviane"]]


    func getEvents() -> Array<Event> {
        
        let events = DataManager().createEventDummyData()
        
        return events
        
    }
    
}