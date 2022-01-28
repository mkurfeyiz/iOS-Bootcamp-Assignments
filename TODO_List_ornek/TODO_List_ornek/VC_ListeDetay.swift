//
//  VC_ListeDetay.swift
//  TODO_List_ornek
//
//  Created by mkurfeyiz on 21.01.2022.
//

import UIKit
import CoreData

//lifecyclelari p
class VC_ListeDetay: UIViewController {
    
    @IBOutlet var tfBaslik: UITextField!
    @IBOutlet var tfAciklama: UITextField!
    @IBOutlet var txtvDetay: UITextView!
    
    var todoItem: TodoTable!
    var updateFlag: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todoItem {
            tfBaslik.text = todo.baslik
            tfAciklama.text = todo.aciklama
            txtvDetay.text = todo.detay
        }
    }
    
    //Burada update mi save mi kontrolu icin todoItemin nil olup olmamasi uzerinden
    //anlayabiliriz.
    @IBAction func btnSaveTodo_TUI(_ sender: Any) {
        //Bu ekranda aciklama 10 karakterden fazla girilemeyecek halde olmali
        //10 karakterden sonra isEditable false olmasi lazim.
        if tfAciklama.text?.count ?? 0 > 10 {
            aciklamaAlert(title: "Açıklama Hatası", message: "Açıklama, 10 karakterden fazla olamaz")
        } else {
            if self.updateFlag {
                updateTodo()
            } else {
                saveTodo(baslik: tfBaslik.text ?? "", aciklama: tfAciklama.text ?? "", detay: txtvDetay.text ?? "")
            }
            performSegue(withIdentifier: "sgDetayToListe", sender: nil)
        }
        
    }
    
    //CoreData
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    func saveTodo(baslik: String, aciklama: String, detay: String) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "TodoTable", in: context)
        
        let kayit = NSManagedObject(entity: entity!, insertInto: context)
        
        kayit.setValue(baslik, forKey: "baslik")
        kayit.setValue(aciklama, forKey: "aciklama")
        kayit.setValue(detay, forKey: "detay")
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func updateTodo() {
        
        todoItem.baslik = tfBaslik.text
        todoItem.aciklama = tfAciklama.text
        todoItem.detay = txtvDetay.text
        
        //icerigi degistikten sonra bu satir ile kaydi guncelleyebiliriz.
        try? getContext().save()
    }
    
    func aciklamaAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        
        
        present(ac, animated: true, completion: nil)
    }

}
