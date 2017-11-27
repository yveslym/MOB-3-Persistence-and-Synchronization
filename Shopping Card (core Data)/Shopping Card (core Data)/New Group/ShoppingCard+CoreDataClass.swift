//
//  ShoppingCard+CoreDataClass.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ShoppingCard)
public class ShoppingCard: NSManagedObject {

}
extension ShoppingCard{
    convenience init(context: NSManagedObjectContext) {
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "ShoppingCard", in:
            context)!
        
        self.init(entity: entityDescription, insertInto: context)
}
}
