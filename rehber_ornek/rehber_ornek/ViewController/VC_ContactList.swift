//
//  VC_ContactList.swift
//  rehber_ornek
//
//  Created by mkurfeyiz on 24.01.2022.
//

import UIKit

class VC_ContactList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tvContacts: UITableView!
    
    var contactList = [ContactTable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contactList = ContactDAL.getAllContacts() ?? []
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgUpdate", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgUpdate" {
            let vc = segue.destination as! VC_Detail
            
            vc.contact = self.contactList[sender as! Int]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Bu koddan sonra tvcdeki awakeFromNib calisiyor ve her sey initialize ediliyor.
        let cell = Bundle.main.loadNibNamed("TVC_Contact", owner: self, options: nil)?.first as! TVC_Contact
        
        cell.contact = self.contactList[indexPath.row]
        
        return cell
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        tvContacts.reloadData()
    }

}
