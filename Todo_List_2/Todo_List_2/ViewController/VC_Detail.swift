//
//  VC_Detail.swift
//  Todo_List_2
//
//  Created by mkurfeyiz on 24.01.2022.
//

import UIKit

class VC_Detail: UIViewController, UITextViewDelegate {

    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var txtvDescription: UITextView!
    @IBOutlet var txtvDetail: UITextView!
    @IBOutlet var lblCharacterCount: UILabel!
    
    var todo: TodoTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtvDescription.delegate = self

        if let todoItem = self.todo {
            tfTitle.text = todoItem.title
            txtvDescription.text = todoItem.desc
            txtvDetail.text = todoItem.detail
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        lblCharacterCount.text = "\(textView.text.count) / 10"
    }
    
    //Prevents editing after 10 char
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + text.count <= 10
    }

    @IBAction func btnSaveTodo_TUI(_ sender: UIButton) {
        
        if let todoItem = self.todo {
            //Update
            todoItem.title = tfTitle.text
            todoItem.desc = txtvDescription.text
            todoItem.detail = txtvDetail.text
            
            TodoDAL.updateTodo()
        } else {
            //Save
            TodoDAL.saveTodo(title: tfTitle.text ?? "", description: txtvDescription.text ?? "", detail: txtvDetail.text ?? "")
        }
        performSegue(withIdentifier: "sgUpdateList", sender: nil)
    }
}
