//
//  VC_Kaydol.swift
//  final_project
//
//  Created by mkurfeyiz on 3.02.2022.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class VC_Kaydol: UIViewController {

    @IBOutlet var tfAd: UITextField!
    @IBOutlet var tfSoyad: UITextField!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfTelefon: UITextField!
    @IBOutlet var tfSifre: UITextField!
    @IBOutlet var tfSifreTekrar: UITextField!
    @IBOutlet var scKullaniciTuru: UISegmentedControl!
    @IBOutlet var tvTanitim: UITextView!
    @IBOutlet var lblTanitim: UILabel!
    
    var kullanici: Kullanici!
    var kullaniciTuru: KullaniciTuru = KullaniciTuru.hizmetAlan
    var ref: DatabaseReference!
    var hizmet = Hizmet()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tvTanitim.isHidden = true
        lblTanitim.isHidden = true
        ref = Database.database().reference()
    }
    

    @IBAction func btnKaydol_TUI(_ sender: Any) {
        
        if isValid() {
            Auth.auth().createUser(withEmail: self.tfEmail.text!, password: tfSifre.text!) { authResult, error in
                if error != nil {
                    self.alert(baslik: "", mesaj: "Mevcut bir kullanıcı hesabı oluşturdunuz")
                } else {
                    let id = authResult?.user.uid
                    self.kullanici = Kullanici(ad: self.tfAd.text!, soyad: self.tfSoyad.text!, telefon: self.tfTelefon.text!, email: self.tfEmail.text!, sifre: self.tfSifre.text!, tip: self.kullaniciTuru.rawValue, tanitim: self.tvTanitim.text)
                    let dict: [String : Any] = [
                        "id" : id!,
                        "ad" : self.kullanici.ad!,
                        "soyad" : self.kullanici.soyad!,
                        "telefon": self.kullanici.telefon!,
                        "email" : self.kullanici.email!,
                        "sifre" : self.kullanici.sifre!,
                        "tip" : self.kullanici.tip!,
                        "tanitim" : self.kullanici.tanitim ?? "",
                        "hizmetler" : ""
                    ]
                    
                    //Veritabanina kayit yaptigimiz yer
                    self.ref.child("Kullanici").child(id!).setValue(dict)
                    
                    Auth.auth().signIn(withEmail: self.tfEmail.text!, password: self.tfSifre.text!) { [weak self] authResult, error in
                        guard let strongSelf = self else { return }
                        
                        //Kullanici tipini autologin icin kaydediyoruz.
                        UserDefaults.standard.set(self!.kullanici.tip, forKey: "tip")
                        UserDefaults.standard.synchronize()
                      
                        if self?.kullaniciTuru == KullaniciTuru.hizmetAlan {
                            let hizmetAlan = self?.storyboard?.instantiateViewController(identifier: Constants.Storyboard.hizmetAlanController) as? NC_HizmetAlan
                            
                            self?.view.window?.rootViewController = hizmetAlan
                        } else {
                            let hizmetVeren = self?.storyboard?.instantiateViewController(identifier: Constants.Storyboard.hizmetVerenController) as? NC_HizmetVeren
                            
                            self?.view.window?.rootViewController = hizmetVeren
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func scKullaniciTuru_VC(_ sender: Any) {
        switch scKullaniciTuru.selectedSegmentIndex {
        case 0:
            //hizmet alan
            tvTanitim.isHidden = true
            lblTanitim.isHidden = true
            kullaniciTuru = KullaniciTuru.hizmetAlan
        case 1:
            //hizmet veren
            tvTanitim.isHidden = false
            lblTanitim.isHidden = false
            kullaniciTuru = KullaniciTuru.hizmetVeren
        default:
            break
        }
    }
    
    func isValid() -> Bool {
        //Boş Alan Kontrolü
        if (tfAd.text?.isEmpty)! || tfSoyad.text?.isEmpty ?? true || tfEmail.text?.isEmpty ?? true || tfTelefon.text?.isEmpty ?? true || (tfSifre.text?.isEmpty ?? true && tfSifreTekrar.text?.isEmpty ?? true) {
            alert(baslik: "Boş Alan", mesaj: "Alanlardan herhangi birisi boş bırakılamaz.")
            return false
            
        } else {
            //Gerekiyorsa Tanıtım Alanı
            if kullaniciTuru == KullaniciTuru.hizmetVeren && tvTanitim.text.isEmpty {
                alert(baslik: "Uyarı", mesaj: "Tanıtım Alanı Boş Geçilemez.")
                return false
            } else {
                //Email Regex Kontrolü
                if isValidEmail(tfEmail.text!) {
                    //Sifre Kontrol
                    if tfSifre.text!.count < 6 || tfSifre.text != tfSifreTekrar.text {
                        alert(baslik: "Şifre Hatası", mesaj: "Şifre 6 karakterden küçük veya şifreler eşleşmiyor.")
                        return false
                    }
                    
                } else {
                    alert(baslik: "Email Hatası", mesaj: "Email formatı uyumlu değil")
                    return false
                }
            }
        }
        
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func alert(baslik: String, mesaj: String) {
        let ac = UIAlertController(title: baslik, message: mesaj, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }
    

}
