
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
        let dataMNG: DataMNG = DataMNG()
        dataMNG.grabMembersFromAPI { (members) in
            self.members = members
        }
    }
}