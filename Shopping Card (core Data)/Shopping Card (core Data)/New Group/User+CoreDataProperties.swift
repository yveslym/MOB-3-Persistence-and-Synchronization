//
//  User+CoreDataProperties.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var shoppingCard: ShoppingCard?
    @NSManaged public var uid: String?

}
