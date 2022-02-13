//
//  VC_HizmetAlan.swift
//  final_project
//
//  Created by mkurfeyiz on 3.02.2022.
//

import UIKit
import Firebase
import FirebaseDatabase

class VC_HizmetAlan: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tvHizmetAlan: UITableView!
    
    var ref: DatabaseReference!
    var hizmetList = [Hizmet]()
    var hizmetVerenKullaniciList = [Kullanici]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.ref = Database.database().reference()
        self.getValues()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgDetay", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetay" {
            let vc = segue.destination as! VC_HizmetAlanDetay
            
            vc.kullanici = self.hizmetList[sender as! Int].kullanici
            vc.hizmet = self.hizmetList[sender as! Int]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hizmetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TVC_HizmetAlan", owner: self, options: nil)?.first as! TVC_HizmetAlan
        
        cell.lblHizmetBaslik.text = hizmetList[indexPath.row].baslik
        
        return cell
    }
    
    @IBAction func btnCikisYap_TUI(_ sender: UIBarButtonItem) {
        Globals.logoutAlert(self)
    }
    
    func getValues() {
        //Oncelikle kullanici tipi 'Hizmet Veren' olan kullanicilari dbden aldik.
        let kullaniciRef = ref.child("Kullanici").queryOrdered(byChild: "tip").queryEqual(toValue: "Hizmet Veren")
        var kullaniciList = [Kullanici]()
        
        kullaniciRef.getData() { error, snapshot in
            
            if error != nil {
                //
                print(error!.localizedDescription)
            } else {
                //Sorgu sonucunda gelen kullanicilarin bilgilerini aldik ve kullanici nesneleri olusturduk.
                if let kullaniciDict = snapshot.value as? [String: AnyObject] {
                    var hList = [Hizmet]()
                    for kullanici in kullaniciDict {
                        if let dict = kullanici.value as? NSDictionary {
                            
                            let ad = dict["ad"] as? String ?? ""
                            let soyad = dict["soyad"] as? String ?? ""
                            let email = dict["email"] as? String ?? ""
                            let telefon = dict["telefon"] as? String ?? ""
                            let sifre = dict["sifre"] as? String ?? ""
                            let tip = dict["tip"] as? String ?? ""
                            let tanitim = dict["tanitim"] as? String ?? ""
                            
                            let newKullanici = Kullanici(ad: ad, soyad: soyad, telefon: telefon, email: email, sifre: sifre, tip: tip, tanitim: tanitim)
                            
                            //Olusan kullanici nesnelerinde bulunan hizmetler alanini doldurabilmek icin
                            //veritabanindaki hizmetler alanindan da verileri cektik.
                            for hizmet in dict["hizmetler"] as! [String: AnyObject] {
                                if let dict = hizmet.value as? NSDictionary {
                                    
                                    let key = hizmet.key
                                    let baslik = dict["baslik"] as? String ?? ""
                                    let aciklama = dict["aciklama"] as? String ?? ""
                                    
                                    //Yeni hizmet nesneleri olusturduk ve her bir hizmetin sahibi olan kullaniciyi
                                    //o hizmete atadik.
                                    let newHizmet = Hizmet(baslik: baslik, aciklama: aciklama)
                                    newHizmet.id = key
                                    newHizmet.kullanici = newKullanici
                                    hList.append(newHizmet)
                                }
                            }
                            self.hizmetList = hList
                            
                            newKullanici.hizmet = hList
                            
                            kullaniciList.append(newKullanici)
                            
                        }
                    }
                    self.hizmetVerenKullaniciList = kullaniciList
                }
            }
            //Reload data
            DispatchQueue.main.async {
                self.tvHizmetAlan.reloadData()
            }
        }
    }

}
