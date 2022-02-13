//
//  ViewController.swift
//  final_project
//
//  Created by mkurfeyiz on 3.02.2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet var tfSifre: UITextField!
    @IBOutlet var tfEmail: UITextField!
    
    var kullanici: Kullanici!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database(url: "https://final-project-88b03-default-rtdb.firebaseio.com/").reference()
        /*UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "sifre")
        UserDefaults.standard.removeObject(forKey: "tip")
        if UserDefaults.standard.string(forKey: "email") != nil {
            signIn(email: UserDefaults.standard.string(forKey: "email")!, sifre: UserDefaults.standard.string(forKey: "sifre")!)
        }*/
        //try! Auth.auth().signOut()
        if Auth.auth().currentUser != nil {
            self.routeTo()
        }
        
    }

    @IBAction func btnGirisYap_TUI(_ sender: Any) {
        let email = tfEmail.text
        let sifre = tfSifre.text
        
        self.signIn(email: email!, sifre: sifre!)
        
    }
    
    func signIn(email: String, sifre: String) {
        Auth.auth().signIn(withEmail: email, password: sifre) { result, error in
            if error != nil {
                self.alert(baslik: nil, mesaj: error!.localizedDescription)
            } else {
                let id = result?.user.uid
                let kullaniciRef = self.ref.child("Kullanici").queryOrdered(byChild: "id").queryEqual(toValue: "\(id!)")
                
                kullaniciRef.getData() { error, snapshot in
                    
                    if error != nil {
                        self.alert(baslik: nil, mesaj: error!.localizedDescription)
                    } else {
                        if let kullaniciDict = snapshot.value as? [String: AnyObject] {
                            
                            for kullanici in kullaniciDict {
                                if let dict = kullanici.value as? NSDictionary {
                                    
                                    let tip = dict["tip"] as? String ?? ""
                                    
                                    UserDefaults.standard.set(tip, forKey: "tip")
                                }
                            }
                            
                            self.routeTo()
                        }
                    }
                }
            }
        }
    }
    
    func routeTo() {
        if let tip = UserDefaults.standard.string(forKey: "tip") {
            if tip == "Hizmet Veren" {
                let hizmetVeren = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.hizmetVerenController) as? NC_HizmetVeren
                navigationController?.popToViewController(hizmetVeren!, animated: true)
                //self.view.window?.rootViewController = hizmetVeren
            } else {
                let hizmetAlan = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.hizmetAlanController) as? NC_HizmetAlan
                
                navigationController?.popToViewController(hizmetAlan!, animated: true)
                //self.view.window?.rootViewController = hizmetAlan
            }
        } else {
            alert(baslik: "Giriş Hatası", mesaj: "Hesaba giriş yaparken bir sorun meydana geldi.")
        }
    }
    
    func alert(baslik: String?, mesaj: String) {
        let ac = UIAlertController(title: baslik ?? "", message: mesaj, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }
}

