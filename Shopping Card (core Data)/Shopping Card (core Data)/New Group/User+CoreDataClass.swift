//
//  User+CoreDataClass.swift
//  Shopping Card (core Data)
//
//  Created by Yveslym on 11/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {

}
extension User{
    convenience init(context: NSManagedObjectContext) {
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in:
            context)!
        
        self.init(entity: entityDescription, insertInto: context)
    }
    static var instance: User = {
       let stack = CoreDataStack.instance
        let _user = User(context: stack.viewContext)
        let card = ShoppingCard(context: stack.viewContext)
        card.user = _user
        _user.shoppingCard = card
        return _user
    }()
}
