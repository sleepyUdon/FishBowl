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
    
    
     
    func saveToAddressBook(image: NSData?, name: String, email: String?, phone: String) {
        
        //the profile image
        contact.imageData = image
        contact.givenName = name
        contact.familyName = ""
        
        let homeEmail = CNLabeledValue(label: CNLabelHome, value: "")
        let workEmail = CNLabeledValue(label: CNLabelWork, value: email!)
        contact.emailAddresses = [homeEmail, workEmail]
        
        contact.phoneNumbers = [ CNLabeledValue(
            label: CNLabelPhoneNumberiPhone,
            value: CNPhoneNumber(stringValue:phone)
        )]
        
        //save new contact
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.addContact(contact, toContainerWithIdentifier: nil)
        try! store.executeSaveRequest(saveRequest)
    }
    
}


