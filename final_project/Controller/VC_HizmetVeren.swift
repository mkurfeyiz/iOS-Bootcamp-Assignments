//
//  VC_HizmetVeren.swift
//  final_project
//
//  Created by mkurfeyiz on 3.02.2022.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class VC_HizmetVeren: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tvHizmetVeren: UITableView!
    
    var hizmetList = [Hizmet]()
    var kullaniciUid = Auth.auth().currentUser!.uid
    var ref: DatabaseReference!
    var hizmetRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        hizmetRef = ref.child("Kullanici").child(kullaniciUid).child("hizmetler")
        
        hizmetleriGetir()
        tvHizmetVeren.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hizmetList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgGuncelle", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgGuncelle" {
            let vc = segue.destination as! VC_HizmetVerenDetay
            
            vc.hizmet = self.hizmetList[sender as! Int]
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil"){
            contextualAction, view, boolValue in
            let hizmet = self.hizmetList[indexPath.row]
            //silme
            self.hizmetRef.child(hizmet.id).removeValue()
            
            self.hizmetleriGetir()
            //self.tvHizmetVeren.reloadData()

        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TVC_HizmetVeren", owner: self, options: nil)?.first as! TVC_HizmetVeren
        
        let hizmet = self.hizmetList[indexPath.row]
        
        cell.lblBaslik.text = hizmet.baslik
        cell.lblAciklama.text = hizmet.aciklama
        
        return cell
    }

    @IBAction func btnCikisYap(_ sender: UIBarButtonItem) {
        Globals.logoutAlert(self)
    }
    
    @IBAction func unwindFromHizmetVerenDetay(segue: UIStoryboardSegue) {
        hizmetleriGetir()
        //tvHizmetVeren.reloadData()
    }
    
    func hizmetleriGetir() {
        var hList = [Hizmet]()
        hizmetRef.observe(.value) { /*error,*/ snapshot in
            
            if let hizmetlerDict = snapshot.value as? [String: AnyObject] {
                for hizmet in hizmetlerDict {
                    if let dict = hizmet.value as? NSDictionary {
                        
                        let key = hizmet.key
                        let baslik = dict["baslik"] as? String ?? ""
                        let aciklama = dict["aciklama"] as? String ?? ""
                        
                        let newHizmet = Hizmet(baslik: baslik, aciklama: aciklama)
                        newHizmet.id = key
                        hList.append(newHizmet)
                    }
                }
            } else {
                hList = [Hizmet]()
            }
            
            self.hizmetList = hList
            /*DispatchQueue.main.async {
                self.tvHizmetVeren.reloadData()
            }*/
        }
        
    }
}
