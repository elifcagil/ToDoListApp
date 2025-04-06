//
//  ViewController.swift
//  To-Do-List
//
//  Created by ELİF ÇAĞIL on 3.04.2025.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  
    var isFiltered :Bool = false
    let viewModel = ToDoListViewModel()
    
    
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "TO DO LIST"
        
        
        viewModel.onItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.getAllItems()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let gidilecekVc = segue.destination as! ToDoDetayViewController
        gidilecekVc.todo = viewModel.ToDoList[index!]
        
    }
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "Yeni Görev", message: "Lütfen eklenecek görevi giriniz", preferredStyle: .alert)
        
        alert.addTextField{ textfield in
            textfield.placeholder = "Görev Adı"
        }
        alert.addTextField() {tf in
            tf.placeholder = "Görev Detayları"
        }
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        
        
        
        let pickerViewController = UIViewController()
        pickerViewController.view = datePicker
        pickerViewController.preferredContentSize = CGSize(width: 250, height: 250)
        alert.setValue(pickerViewController, forKey: "contentViewController")
        
        
        
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel,handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text,!text.isEmpty ,let descField = alert.textFields?.last, let desc = descField.text
            else { return }
            let selectedDate = datePicker.date
            self?.viewModel.createItems(name: text,date: selectedDate,desc: desc)
        }
                                     ))
        present(alert,animated: true)
        
    }
    
    @IBAction func isDoneButton(_ sender: Any) {
        isFiltered.toggle()
        if isFiltered{
            viewModel.fetchCompleted()
        }else{
            viewModel.getAllItems()
        }
            
        }
    }
                                                
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ToDoList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.ToDoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" ,for:indexPath) as! ToDoTableViewCell
        cell.ToDoName.text = item.name
        let tf = DateFormatter()
        tf.dateFormat = "dd/MM/yyyy"
        cell.ToDoCreated.text = tf.string(from: item.endDate!)
        cell.hucreProtokol = self
        cell.indexPath = indexPath
        if item.isCompleted{
            cell.tamamlandıButton.setImage(UIImage(systemName: "inset.filled.circle"), for: .normal)

        }else{
            cell.tamamlandıButton.setImage(UIImage(systemName: "circle"), for: .normal)

        }
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let item = self.viewModel.ToDoList[indexPath.row]
            self.viewModel.deleteItem(item: item)
            completionHandler(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Düzenle") { (action,view,completionHandler)in
            
            let item = self.viewModel.ToDoList[indexPath.row]
            let alert = UIAlertController(title: "Görevi Güncelle", message: nil, preferredStyle: .alert)
            
            alert.addTextField{ textfield in
                textfield.text = item.name
            }
            alert.addTextField() {tf in
                tf.text = item.desc
            }
            
            
            
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.minimumDate = Date()
            
            
            
            let pickerViewController = UIViewController()
            pickerViewController.view = datePicker
            pickerViewController.preferredContentSize = CGSize(width: 250, height: 250)
            alert.setValue(pickerViewController, forKey: "contentViewController")
            
            
            
            alert.addAction(UIAlertAction(title: "Save", style: .default,handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let text = field.text,!text.isEmpty ,let descField = alert.textFields?.last, let desc = descField.text
                else { return }
                let selectedDate = datePicker.date
                self?.viewModel.updateItem(item: item, newName: text, newDate: selectedDate, newdesc: desc)
            }))
            alert.addAction(UIAlertAction(title: "İptal", style: .cancel))
            self.present(alert,animated: true)
            completionHandler(true)
            
        }
        editAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
}



extension ViewController : TableViewCellDelegate {
    func Completedtask(indexPath: IndexPath) {
        let cell = viewModel.ToDoList[indexPath.row]
        
        cell.isCompleted.toggle()
        CoreDataManager.shared.saveContext()
        
        print("buton çalışıyor,\(cell.isCompleted)")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }    
}

