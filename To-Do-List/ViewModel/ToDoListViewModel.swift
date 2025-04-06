
//
//  ToDoListViewModel.swift
//  To-Do-List
//
//  Created by ELİF ÇAĞIL on 6.04.2025.
//

import Foundation
import CoreData
import UIKit

class ToDoListViewModel {
    
    
    var ToDoList: [ToDoListItem] = [] {
        didSet {
            onItemsUpdated?()  // items değişince haber ver
        }
    }
    
    var onItemsUpdated: (() -> Void)?
    
    func getAllItems(){
        ToDoList = CoreDataManager.shared.fetchAllItems()
        sortItems()
    }
    
    func createItems(name:String,date:Date?,desc:String){
        CoreDataManager.shared.createItem(name: name, date: date, desc: desc)
        getAllItems()
    }
    
    func deleteItem(item:ToDoListItem){
        CoreDataManager.shared.deleteItem(item)
        getAllItems()
        
    }
    func sortItems() {
            ToDoList.sort { (item1, item2) -> Bool in
                // Tamamlanmış olanlar en alta gelsin
                if item1.isCompleted != item2.isCompleted {
                    return !item1.isCompleted // Completed = true olan öğe en alta gelir
                }
                return item1.createdAt! < item2.createdAt! // Eğer tamamlanmışsa, oluşturulma tarihine göre sıralanır
            }
        }
    
    func updateItem(item : ToDoListItem,newName:String,newDate:Date?,newdesc:String){
        CoreDataManager.shared.updateItem(item, newName: newName, newDate: newDate, newDesc: newdesc)
        getAllItems()
        
    }
    
    func fetchCompleted(){
        ToDoList = CoreDataManager.shared.fetchCompletedItems()
        sortItems()
        
    }
    
   
}
