//
//  User.swift
//  FishBowl
//
//  Created by Yevhen Kim on 2016-08-09.
//  Copyright © 2016 Yevhen Kim. All rights reserved.
//

import Foundation

class User: NSObject {
    var userId: String
    var name: String
    var bio: String     
    var email: String?
    var image: NSData?
    var phone: String?
    var github: String?
    var linkedin: String?
    var company:String?
    
    
    init(userId: String, name: String, bio:String?, image:NSData?)
    {
        self.name = name
        self.userId = userId
        self.image = image
        self.bio = bio!

        
    }
}

