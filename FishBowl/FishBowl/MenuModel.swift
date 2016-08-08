//
//  MenuTableViewModel.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-06-25.
//  Copyright (c) 2015 Adam Dahan. All rights reserved.
//

import Foundation

public class MenuModel {
    /*
    @name   required initWithCoder
    */
    public class func sectionsCount() -> Int { return 1 }
    
    /*
    @name   required initWithCoder
    */
    public class func sections() -> Dictionary<String, AnyObject> {
        return ["Default"       : ["", "", ""],
                "Preferences"   : ["", "", ""],
                "Other"         : ["", "", ""]]
    }
}