//
//  User.swift
//  FishBowl
//
//  Created by Viviane Chan on 2016-08-09.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String
    var email: String
    var image: String
    var phone: NSNumber
    var github: String
    var linkedin: String
    var title: String
    //    var user: User()
    
    
    
    init(name: String, email:String,image:String, phone: NSNumber, github:String, linkedin:String, title: String) {
        self.name = name
        self.email = email
        self.image = image
        self.phone = phone
        self.github = github
        self.linkedin = linkedin
        self.title = title
        
    }
}

