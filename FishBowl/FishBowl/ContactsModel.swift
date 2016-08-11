//
//  MenuTableViewModel.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-06-25.
//  Copyright (c) 2015 Adam Dahan. All rights reserved.
//

import Foundation
import UIKit

public class ContactsModel: NSObject {
    
    
    /*
    @name   required initWithCoder
    */
    public class func sectionsCount() -> Int { return 1 }
    
    func getUsers() -> Array<User> {
        
        let users = DataManager().createUserDummyData()
        
        return users
        
    }
    
    /*
    @name   required initWithCoder
    */
    
    

}