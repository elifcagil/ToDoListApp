//
//  ToDoDetayViewController.swift
//  To-Do-List
//
//  Created by ELİF ÇAĞIL on 4.04.2025.
//

import UIKit

class ToDoDetayViewController: UIViewController {
    var todo:ToDoListItem?

    @IBOutlet var createdDate: UILabel!
    
   
    @IBOutlet var todoDesc: UILabel!
    
    @IBOutlet var EndDate: UILabel!
    
    @IBOutlet var toDoName: UILabel!
    
    @IBOutlet var iscomp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy - HH:mm"
        
        if let t = todo {
            
            createdDate.text = df.string(from: t.createdAt!)
            EndDate.text = df.string(from: t.endDate!)
            todoDesc.text = t.desc
            toDoName.text = t.name
            if t.isCompleted{
                iscomp.text = "Tamamlandı"
            }else{
                iscomp.text = "Tamamlanmadı"
            }
                

            
            
        }

    }
    

    

}
