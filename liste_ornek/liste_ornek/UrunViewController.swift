//
//  UrunViewController.swift
//  liste_ornek
//
//  Created by mkurfeyiz on 18.01.2022.
//

import UIKit

class UrunViewController: UIViewController {

    @IBOutlet var ivUrun: UIImageView!
    @IBOutlet var lblYeniFiyat: UILabel!
    @IBOutlet var lblEskiFiyat: UILabel!
    @IBOutlet var lblBaslik: UILabel!
    @IBOutlet var lblAltBaslik: UILabel!
    @IBOutlet var txtvAciklama: UITextView!
    
    var urun: Urun!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtvAciklama.isEditable = false
        
        self.ivUrun.image = urun.image
        self.lblYeniFiyat.text = "\(urun.yeniFiyat ?? 0.0) TL"
        self.lblEskiFiyat.text = "\(urun.eskiFiyat ?? 0.0) TL"
        self.lblBaslik.text = urun.adi
        self.lblAltBaslik.text = urun.altBaslik
        self.txtvAciklama.text = urun.aciklama
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*self.ivUrun.image = urun.image
        self.lblYeniFiyat.text = "\(urun.yeniFiyat ?? 0.0) TL"
        self.lblEskiFiyat.text = "\(urun.eskiFiyat ?? 0.0) TL"
        self.lblBaslik.text = urun.adi
        self.lblAltBaslik.text = urun.altBaslik
        self.txtvAciklama.text = urun.aciklama*/
        
    }

}
