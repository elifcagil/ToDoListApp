//
//  Untitled.swift
//  To-Do-List
//
//  Created by ELİF ÇAĞIL on 6.04.2025.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let context: NSManagedObjectContext
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func fetchAllItems() -> [ToDoListItem] {
        let request: NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
            return []
        }
    }

    func fetchCompletedItems() -> [ToDoListItem] {
        let request: NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest()
        request.predicate = NSPredicate(format: "isComp == true")
        do {
            return try context.fetch(request)
        } catch {
            print("Completed fetch failed: \(error.localizedDescription)")
            return []
        }
    }
    
    func createItem(name: String, date: Date?, desc: String) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        newItem.endDate = date
        newItem.desc = desc
        newItem.isComp = false
        saveContext()
    }

    func deleteItem(_ item: ToDoListItem) {
        context.delete(item)
        saveContext()
    }

    func updateItem(_ item: ToDoListItem, newName: String, newDate: Date?, newDesc: String) {
        item.name = newName
        item.endDate = newDate
        item.desc = newDesc
        saveContext()
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save failed: \(error.localizedDescription)")
            }
        }
    }
}
