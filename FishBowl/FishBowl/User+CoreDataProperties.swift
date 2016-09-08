//
//  User+CoreDataProperties.swift
//  FishBowl
//
//  Created by Yevhen Kim on 2016-09-05.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var company: String?
    @NSManaged var email: String?
    @NSManaged var github: String?
    @NSManaged var linkedin: String?
    @NSManaged var name: String?
    @NSManaged var note: String?
    @NSManaged var phone: String?
    @NSManaged var picture: NSData?
    @NSManaged var title: String?
    @NSManaged var userID: String

}
