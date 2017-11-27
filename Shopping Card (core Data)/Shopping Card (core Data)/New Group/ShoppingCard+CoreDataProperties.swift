//
//  ShoppingCard+CoreDataProperties.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData


extension ShoppingCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingCard> {
        return NSFetchRequest<ShoppingCard>(entityName: "ShoppingCard")
    }

    @NSManaged public var numberOfProduct: Int16
    @NSManaged public var product: NSOrderedSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for product
extension ShoppingCard {

    @objc(insertObject:inProductAtIndex:)
    @NSManaged public func insertIntoProduct(_ value: Product, at idx: Int)

    @objc(removeObjectFromProductAtIndex:)
    @NSManaged public func removeFromProduct(at idx: Int)

    @objc(insertProduct:atIndexes:)
    @NSManaged public func insertIntoProduct(_ values: [Product], at indexes: NSIndexSet)

    @objc(removeProductAtIndexes:)
    @NSManaged public func removeFromProduct(at indexes: NSIndexSet)

    @objc(replaceObjectInProductAtIndex:withObject:)
    @NSManaged public func replaceProduct(at idx: Int, with value: Product)

    @objc(replaceProductAtIndexes:withProduct:)
    @NSManaged public func replaceProduct(at indexes: NSIndexSet, with values: [Product])

    @objc(addProductObject:)
    @NSManaged public func addToProduct(_ value: Product)

    @objc(removeProductObject:)
    @NSManaged public func removeFromProduct(_ value: Product)

    @objc(addProduct:)
    @NSManaged public func addToProduct(_ values: NSOrderedSet)

    @objc(removeProduct:)
    @NSManaged public func removeFromProduct(_ values: NSOrderedSet)

}
