
import Foundation
import UIKit

public class ContactsModel: NSObject {
    
    
    /*
    @name   required initWithCoder
    */
    
//    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    let dataManager = appDelegate.dataManager
    
    public class func sectionsCount() -> Int { return 1 }
    
    func getUsers() -> Array<User> {
        
        let contactsFromDummyData = DataManager.createUserDummyData()
        let contactsFromPhone = DataManager.getContacts()
        let contacts = contactsFromPhone + contactsFromDummyData
        
        return contacts
    
    }

}