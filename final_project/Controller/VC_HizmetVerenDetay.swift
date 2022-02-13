//
//  VC_HizmetVerenDetay.swift
//  final_project
//
//  Created by mkurfeyiz on 3.02.2022.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class VC_HizmetVerenDetay: UIViewController {

    @IBOutlet var tfBaslik: UITextField!
    @IBOutlet var tvAciklama: UITextView!
    
    var hizmet: Hizmet!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        if hizmet != nil {
            tfBaslik.text = hizmet.baslik
            tvAciklama.text = hizmet.aciklama
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnKaydet_TUI(_ sender: Any) {
        
        if hizmet != nil {
            //Update
            guard ref.child("Kullanici").child("\(Auth.auth().currentUser!.uid)").child("hizmetler").childByAutoId().key != nil else { return }
            let post = [
                "baslik" : tfBaslik.text,
                "aciklama" : tvAciklama.text
            ]
            let childUpdates = ["/Kullanici/\(Auth.auth().currentUser!.uid)/hizmetler/\(hizmet.id!)": post]
            ref.updateChildValues(childUpdates)
            
        } else {
            //Create
            hizmet = Hizmet(baslik: tfBaslik.text ?? "", aciklama: tvAciklama.text ?? "")
            
            let hizmetDict: [String : Any] = [
                "baslik" : self.hizmet.baslik!,
                "aciklama" : self.hizmet.aciklama!
            ]
            var newRef = self.ref.child("Kullanici").child("\(Auth.auth().currentUser!.uid)").child("hizmetler")
            newRef = newRef.childByAutoId()
            newRef.setValue(hizmetDict)
            
            hizmet.id = newRef.key!
            
        }
        
        performSegue(withIdentifier: "unwindFromHizmetVerenDetay", sender: nil)
        
    }

}
