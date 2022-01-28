//
//  KategoriViewController.swift
//  liste_ornek
//
//  Created by mkurfeyiz on 18.01.2022.
//

import UIKit

class KategoriViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var lblKategori: UILabel!
    @IBOutlet var tvUrunler: UITableView!
    var kategori: Kategori!
    //kategori icinden aldigimiz icin buna ihtiyac yok
    //var urunListesi = [Urun]()

    override func viewDidLoad() {
        super.viewDidLoad()
        lblKategori.text = kategori.adi
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //lblKategori.text = kategori.adi
        //urunListesi = kategori.urunList
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategori.urunList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Urun listesi
        let urun = kategori.urunList[indexPath.row]
        let cell = Bundle.main.loadNibNamed("TVC_Urun", owner: self, options: nil)?.first as! TVC_Urun
        cell.lblBaslik.text = urun.adi
        cell.lblAltBaslik.text = urun.altBaslik
        cell.ivUrun.image = urun.image
        cell.lblYeniFiyat.text = "\(urun.yeniFiyat ?? 0.0) TL"
        
        //eski fiyat yoksa veya yeni fiyattan kucukse gizle
        if let eskiFiyat = urun.eskiFiyat {
            if eskiFiyat < urun.yeniFiyat ?? 0.0 {
                cell.lblEskiFiyat.isHidden = true
            } else {
                //strikethrough islemi icin attributedText olusturduk.
                let strAttribute = NSMutableAttributedString(string: "\(eskiFiyat) TL")
                strAttribute.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: strAttribute.length))
                cell.lblEskiFiyat.attributedText = strAttribute
            }
        } else {
            cell.lblEskiFiyat.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgUrunDetay", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgUrunDetay" {
            let vc = segue.destination as! UrunViewController
            vc.urun = kategori.urunList[sender as! Int]
        }
    }
    
    @IBAction func backToKategoriVC(segue: UIStoryboardSegue) {
        
    }

}
