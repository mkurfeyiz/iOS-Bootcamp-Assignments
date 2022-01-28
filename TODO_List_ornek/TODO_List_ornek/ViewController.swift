//
//  ViewController.swift
//  TODO_List_ornek
//
//  Created by mkurfeyiz on 21.01.2022.
//

import UIKit
import CoreData

//getContext ve diger db islemlerini kullanabilmek icin ayri bir DAL classi tanimlamak
//en mantiklisi, ayri bir class olmadigi icin diger controllerlarda kod tekrarina yol acti
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tvTodo: UITableView!
    
    var todoItem: TodoTable!
    static var todoList = [TodoTable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //saveTodo(baslik: "Task 2", aciklama: "Test 2", detay: "Uygulama testi 2")
        getAllTodo()
        
    }
    
    //tiklandiginda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgGuncelle", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgGuncelle" {
            let vc = segue.destination as! VC_ListeDetay

            vc.todoItem = ViewController.todoList[sender as! Int]
            vc.updateFlag = true
        } else if segue.identifier == "sgYeni" {
            let vc = segue.destination as! VC_ListeDetay
            
            vc.updateFlag = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TVC_ListeDetay", owner: self, options: nil)?.first as! TVC_ListeDetay
        
        cell.lblBaslik.text = ViewController.todoList[indexPath.row].baslik
        cell.lblAciklama.text = ViewController.todoList[indexPath.row].aciklama
        cell.todoItem = ViewController.todoList[indexPath.row]
        cell.tableView = self.tvTodo
        
        return cell
    }
    
    @IBAction func unwindToListe(segue: UIStoryboardSegue) {
        //Unwinddan sonra cellin secili kalmamasi icin
        tvTodo.reloadData()
    }
    
    //CoreData
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    //Verileri dbden almak icin
    func getAllTodo() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoTable")
        try? ViewController.todoList = getContext().fetch(fetchRequest) as! [TodoTable]
        self.tvTodo.reloadData()
        
    }

}

