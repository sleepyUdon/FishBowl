//
//  MenuTableViewModel.swift
//  Claremont
//
//  Created by Adam Dahan on 2015-06-25.
//  Copyright (c) 2015 Adam Dahan. All rights reserved.
//

import Foundation
import UIKit

public class MenuModel: NSObject {
    
    
    /*
    @name   required initWithCoder
    */
    public class func sectionsCount() -> Int { return 1 }
    
    /*
    @name   required initWithCoder
    */
    var events = ["Event1":["Group":"Random","EventTitle":"Lighhouse Labs Demo Day","Date":"Monday","Participants" : "Viviane"]]

    var contacts = ["Users":[["FirstName":"Viviane"],["LastName":"Chan"],["Title":"iOS Developer"],["Company" : "Lighthouse Labs"]]]

    


}