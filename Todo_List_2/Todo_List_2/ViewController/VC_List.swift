//
//  VC_List.swift
//  Todo_List_2
//
//  Created by mkurfeyiz on 24.01.2022.
//

import UIKit

class VC_List: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tvTodo: UITableView!
    //var todoList = [TodoTable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        TodoDAL.tableView = self.tvTodo
        TodoDAL.getTodos()
        //todoList = TodoDAL.getTodos() ?? []
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgUpdate", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgUpdate" {
            let vc = segue.destination as! VC_Detail
            
            vc.todo = TodoDAL.todoList?[sender as! Int]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoDAL.todoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TVC_Todo", owner: self, options: nil)?.first as! TVC_Todo
        
        cell.todoItem = TodoDAL.todoList?[indexPath.row]
        
        return cell
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        //deselect the previously selected cell.
        tvTodo.reloadData()
    }
    
    /*func deleteTodo(data: TodoTable) {
        TodoDAL.deleteTodo(todo: data)
        todoList = TodoDAL.getTodos() ?? []
        self.tvTodo.reloadData()
    }*/

}
