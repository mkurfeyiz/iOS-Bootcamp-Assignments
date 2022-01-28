//
//  VC_Detail.swift
//  rehber_ornek
//
//  Created by mkurfeyiz on 24.01.2022.
//

import UIKit

// branch xcodeb1
class VC_Detail: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tvPhones: UITableView!
    @IBOutlet var ivPhoto: UIImageView!
    @IBOutlet var tfFirstName: UITextField!
    @IBOutlet var tfLastName: UITextField!
    @IBOutlet var tvPhone: UITableView!
    
    @IBOutlet var tfPhone: UITextField!
    @IBOutlet var btnSavePhone: UIButton!
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnAddPhone: UIButton!
    
    var phoneList = [PhonesTable]()
    var contact: ContactTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tfPhone.isHidden = true
        btnSavePhone.isHidden = true
        
        if self.contact != nil {
            tfFirstName.text = contact.firstName
            tfLastName.text = contact.lastName
            ivPhoto.image = UIImage(data: contact.photo!)
            
            phoneList = PhoneDAL.getPhonesByContactId(ownerId: contact.id ?? UUID()) ?? []
            
        } else {
            //Hide if it's a save operation
            btnDelete.isHidden = true
            btnAddPhone.isHidden = true
        }
    }
    
    //Swipe left and delete phone
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PhoneDAL.deletePhone(phone: phoneList[indexPath.row])
            phoneList = PhoneDAL.getPhonesByContactId(ownerId: contact.id!) ?? []
            tvPhones.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TVC_Phones", owner: self, options: nil)?.first as! TVC_Phones
        
        cell.lblPhone.text = phoneList[indexPath.row].phone
        
        return cell
    }

    @IBAction func btnSave_TUI(_ sender: UIButton) {
        if self.contact != nil {
            //update
            contact.firstName = tfFirstName.text
            contact.lastName = tfLastName.text
            ContactDAL.update()
        } else {
            ContactDAL.saveContact(fname: tfFirstName.text ?? "", lname: tfLastName.text ?? "", image: UIImage(named: "default-pp")!)
        }
        
        performSegue(withIdentifier: "sgDetailToContacts", sender: nil)
    }
    
    @IBAction func btnDelete_TUI(_ sender: UIButton) {
        delete(contact: contact)
        
        
        
    }
    
    @IBAction func btnSavePhone_TUI(_ sender: UIButton) {
        PhoneDAL.savePhone(ownerId: contact.id!, phone: tfPhone.text!)
        phoneList = PhoneDAL.getPhonesByContactId(ownerId: contact.id!) ?? []
        tvPhones.reloadData()
        //After adding phone
        setHiddenState(savePhone: false)
    }
    
    @IBAction func btnShowPhoneTf_TUI(_ sender: Any) {
        setHiddenState(savePhone: true)
    }
    
    func setHiddenState(savePhone: Bool) {
        btnAddPhone.isHidden = savePhone
        tfPhone.isHidden = !savePhone
        btnSavePhone.isHidden = !savePhone
    }
    
    func delete(contact: ContactTable) {
        let ac = UIAlertController(title: "Removing Contact", message: "Are you sure about deleting this contact? This cannot be undone", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .default) {
            _ in
            ContactDAL.deleteContact(contact: contact)
            self.performSegue(withIdentifier: "sgDetailToContacts", sender: nil)
        }
        
        ac.addAction(yes)
        ac.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }
    
}
