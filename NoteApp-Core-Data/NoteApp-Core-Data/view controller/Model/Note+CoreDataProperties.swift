//
//  Note+CoreDataProperties.swift
//  NoteApp-Core-Data
//
//  Created by Yveslym on 10/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var creationDate: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var noteBook: Note?

}
