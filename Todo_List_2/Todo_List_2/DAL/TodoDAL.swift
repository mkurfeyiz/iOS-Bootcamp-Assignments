//
//  TodoDAL.swift
//  Todo_List_2
//
//  Created by mkurfeyiz on 24.01.2022.
//

import Foundation
import CoreData
import UIKit

class TodoDAL {
    
    static var tableView: UITableView!
    static var todoList: [TodoTable]?
    
    //db operations
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func getTodos() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoTable")
        self.todoList = try? getContext().fetch(fetchRequest) as? [TodoTable] ?? []
        //return todoList
    }
    
    static func saveTodo(title: String, description: String, detail: String) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "TodoTable", in: context)
        
        let todo = NSManagedObject(entity: entity!, insertInto: context)
        
        todo.setValue(title, forKey: "title")
        todo.setValue(description, forKey: "desc")
        todo.setValue(detail, forKey: "detail")
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    static func updateTodo() {
        try? getContext().save()
    }
    
    static func deleteTodo(todo: TodoTable) {
        getContext().delete(todo)
        try? getContext().save()
    }
}
