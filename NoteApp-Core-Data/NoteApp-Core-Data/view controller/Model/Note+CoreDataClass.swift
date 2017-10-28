//
//  Note+CoreDataClass.swift
//  NoteApp-Core-Data
//
//  Created by Yveslym on 10/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData


public class Note: NSManagedObject {
    
    
    convenience init (text: String = "New Note", context: NSManagedObjectContext){
        if let entity = NSEntityDescription.entity(forEntityName: "Note", in: context){
            self.init(entity: entity, insertInto: context)
            self.creationDate =  NSDate()
            self.text = text
        }
        else{
            fatalError("error happen during saving data into core data")
        }
    }
}
