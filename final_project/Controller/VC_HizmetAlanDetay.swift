//
//  VC_HizmetAlanDetay.swift
//  final_project
//
//  Created by mkurfeyiz on 4.02.2022.
//

import UIKit

class VC_HizmetAlanDetay: UIViewController {
    @IBOutlet var tfAd: UITextField!
    @IBOutlet var tfSoyad: UITextField!
    @IBOutlet var tfTelefon: UITextField!
    @IBOutlet var tfHizmetBasligi: UITextField!
    @IBOutlet var tvHizmetAciklama: UITextView!
    
    var kullanici: Kullanici!
    var hizmet: Hizmet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        alanlariDoldur()
    }
    
    func alanlariDoldur() {
        tfAd.text = kullanici.ad
        tfSoyad.text = kullanici.soyad
        tfTelefon.text = kullanici.telefon
        
        tfHizmetBasligi.text = hizmet.baslik
        tvHizmetAciklama.text = hizmet.aciklama
    }

    @IBAction func btnAra_TUI(_ sender: Any) {
        
        callNumber(phoneNumber: "\(self.kullanici.telefon!)")
    }
    
    func callNumber(phoneNumber: String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
                
            }
        }
    }
}
