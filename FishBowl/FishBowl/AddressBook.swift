//
//  AddressBook.swift
//  FishBowl
//
//  Created by Yevhen Kim on 2016-08-16.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import Contacts

@available(iOS 9.0, *)
class AddressBook {
    //creating a muatble object to add to the contact
    let contact = CNMutableContact()
     
    func saveToAddressBook() {
        
        //the profile image
        contact.imageData = NSData()
        contact.givenName = "Eugene"
        contact.familyName = "Kim"
        
        let homeEmail = CNLabeledValue(label: CNLabelHome, value: "fortranibm@gmail.com")
        let workEmail = CNLabeledValue(label: CNLabelWork, value: "yevhenkim@gmail.com")
        contact.emailAddresses = [homeEmail, workEmail]
        
        contact.phoneNumbers = [ CNLabeledValue(
            label: CNLabelPhoneNumberiPhone,
            value: CNPhoneNumber(stringValue:"(647) 447-7768")
        )]
        
        //save new contact
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.addContact(contact, toContainerWithIdentifier: nil)
        try! store.executeSaveRequest(saveRequest)
    }
    
}


