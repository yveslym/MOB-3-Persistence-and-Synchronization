//
//  Product+CoreDataProperties.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/22/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var title: String?
    @NSManaged public var quantity: Int64
    @NSManaged public var date: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var added: Bool
    @NSManaged public var shoppingCard: ShoppingCard?

}
