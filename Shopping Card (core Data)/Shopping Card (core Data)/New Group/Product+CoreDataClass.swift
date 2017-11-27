//
//  Product+CoreDataClass.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/22/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject {

}

extension Product {
    convenience init(context: NSManagedObjectContext) {
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Product", in:
            context)!
        
        self.init(entity: entityDescription, insertInto: context)
    }
}
