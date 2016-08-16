
import Foundation
import UIKit

public class ParticipantsModel: NSObject {
    static let setParticipants = "didSetParticipants"
    var members: [Member] = [] {
        didSet {
            let notification = NSNotification(name: ParticipantsModel.setParticipants, object: self)
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
    //var events = ["Event1":["Group":"Devhub","EventTitle":"Lighhouse Labs Demo Day","Date":"Monday","Participants" : "Viviane"]]


    func getMembers() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let dataManager = appDelegate.dataManager
        dataManager!.grabMembersFromAPI { (members) in
            self.members = members
        }
        
    }


}