//
//  NoteBook+CoreDataClass.swift
//  NoteApp-Core-Data
//
//  Created by Yveslym on 10/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData


public class NoteBook: NSManagedObject {
    convenience init (text:String = "new Book", context: NSManagedObjectContext){
        
        
        if let entity = NSEntityDescription.entity(forEntityName: "NoteBook", in: context){
            self.init(entity: entity, insertInto: context)
        self.name = text
        self.creationDate = NSDate()
        }
        else{
            fatalError("can create book")
        }
    }

}
