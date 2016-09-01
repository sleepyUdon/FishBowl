//
//  User+CoreDataProperties.swift
//  FishBowl
//
//  Created by Yevhen Kim on 2016-08-24.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

public class User: NSManagedObject {

    @NSManaged var picture: NSData?
    @NSManaged var linkedin: String?
    @NSManaged var github: String?
    @NSManaged var company: String?
    @NSManaged var email: String?
    @NSManaged var phone: String?
    @NSManaged var title: String?
    @NSManaged var name: String?
    @NSManaged var userID: String?

}
