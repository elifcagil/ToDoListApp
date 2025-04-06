//
//  ToDoListItem+CoreDataProperties.swift
//  To-Do-List
//
//  Created by ELİF ÇAĞIL on 3.04.2025.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var isComp: NSNumber? //objc c de bool değerler desteklenmez core data bool değerleri NSNumber tüürnde saklar.
    @NSManaged public var desc : String?

}

extension ToDoListItem : Identifiable {
    
    var isCompleted: Bool {
           get {
               return isComp?.boolValue ?? false
           }
           set {
               isComp = NSNumber(value: newValue)
           }
       }

}
