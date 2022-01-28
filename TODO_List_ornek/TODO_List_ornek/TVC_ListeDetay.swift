//
//  TVC_ListeDetay.swift
//  TODO_List_ornek
//
//  Created by mkurfeyiz on 21.01.2022.
//

import UIKit
import CoreData

//Ana controllerda silme fonkunu yazip burada o fonku cagirmam gerekiyordu.
class TVC_ListeDetay: UITableViewCell {

    @IBOutlet var lblBaslik: UILabel!
    @IBOutlet var lblAciklama: UILabel!
    
    var todoItem: TodoTable!
    var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnDeleteTodo_TUI(_ sender: UIButton) {
        deleteTodo(kayit: todoItem)
    }
    
    //CoreData
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    func deleteTodo(kayit: TodoTable) {
        getContext().delete(kayit)
        ViewController.todoList.remove(at: ViewController.todoList.firstIndex(of: kayit)!)
        print(ViewController.todoList.count)
        try? getContext().save()
        tableView.reloadData()
    }
}
