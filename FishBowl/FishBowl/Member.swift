//
//  Member.swift
//  FishBowl
//
//  Created by Yevhen Kim on 2016-08-11.
//  Copyright © 2016 Yevhen Kim. All rights reserved.
//

import Foundation

class Member: NSObject {
    
    var memberId: String
    var memberName: String
    var memberBio: String?
    var memberImage: Data?
    var memberPhone: String?
    var memberEmail: String?
    var memberGithub: String?
    var memberLinkedin: String?
    var memberCompany: String?
    var memberNote: String?
    var memberIsAdded: Bool?
    
    
    init(memberId:String, memberName:String, memberImage: Data?) {
        self.memberId = memberId
        self.memberName = memberName
        self.memberImage = memberImage
        
    }
}
