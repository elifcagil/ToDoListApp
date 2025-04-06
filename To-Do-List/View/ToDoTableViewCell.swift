//
//  ToDoTableViewCell.swift
//  To-Do-List
//
//  Created by ELİF ÇAĞIL on 3.04.2025.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    var hucreProtokol : TableViewCellDelegate?
    
    var indexPath : IndexPath?
    
    var todoitem = ToDoListItem()
    
    @IBOutlet var tamamlandıButton: UIButton!
    
    @IBOutlet var ToDoName: UILabel!
    
    @IBOutlet var ToDoCreated: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            }
    
    
    
    
    @IBAction func tamamlandıButton(_ sender: UIButton) {
        print("butona tıklandı")
        if let indexPath = indexPath{
            hucreProtokol?.Completedtask(indexPath: indexPath)
        }
    }
}

protocol TableViewCellDelegate {
        func Completedtask(indexPath:IndexPath)
        
    }


