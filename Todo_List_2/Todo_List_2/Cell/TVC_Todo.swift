//
//  TVC_Todo.swift
//  Todo_List_2
//
//  Created by mkurfeyiz on 24.01.2022.
//

import UIKit

class TVC_Todo: UITableViewCell {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    
    var todoItem: TodoTable!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        lblTitle.text = todoItem.title
        lblDescription.text = todoItem.desc
    }
    
    @IBAction func btnDeleteTodo_TUI(_ sender: UIButton) {
        TodoDAL.deleteTodo(todo: self.todoItem)
        TodoDAL.getTodos()
        TodoDAL.tableView.reloadData()
    }
}
