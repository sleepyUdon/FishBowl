
import Foundation
import UIKit

public class ContactsModel: NSObject {
    static let setContacts = "didSetContacts"
    var contacts: [User] = [] {
        didSet {
            let notification = NSNotification(name: ContactsModel.setContacts, object: self)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    
    /*
    @name   required initWithCoder
    */
    
//    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    let dataManager = appDelegate.dataManager
    
    public class func sectionsCount() -> Int { return 1 }
    
    func getUsers() {
        
        let contactsFromDummyData = DataManager.createUserDummyData()
        let contactsFromPhone = DataManager.getContacts()
        let contacts = contactsFromPhone + contactsFromDummyData
    
        self.contacts = contacts
    
    }

}