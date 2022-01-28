//
//  ViewController.swift
//  liste_ornek
//
//  Created by mkurfeyiz on 18.01.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var kategoriList = [Kategori]()
    @IBOutlet var tvKategori: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Urunleri set et
        let u1 = Urun(adi: "Tişört", image: UIImage(named: "tisort1")!, eskiFiyat: 50.0, yeniFiyat: 40.0, altBaslik: "H&M", aciklama: "Oversize tişört - H&M")
        let u2 = Urun(adi: "iPhone 11", image: UIImage(named: "iphone11")!, eskiFiyat: 10000.0, yeniFiyat: 14000.0, altBaslik: "Apple", aciklama: "Apple - iPhone 11 128 GB")
        let u3 = Urun(adi: "iPhone 13", image: UIImage(named: "iphone13")!, eskiFiyat: 12000.0, yeniFiyat: 16000.0, altBaslik: "Apple", aciklama: "Apple - iPhone 13 256 GB")
        let u4 = Urun(adi: "Xiaomi", image: UIImage(named: "xiaomi")!, eskiFiyat: 5000.0, yeniFiyat: 4000.0, altBaslik: "Apple", aciklama: "Apple - iPhone 11 128 GB")
        let u5 = Urun(adi: "Pantolon", image: UIImage(named: "pantolon1")!, eskiFiyat: 200.0, yeniFiyat: 300.0, altBaslik: "Mavi", aciklama: "Mavi - Kot Pantolon")
        
        kategoriList.append(Kategori(adi: "Elektronik", image: UIImage(systemName: "laptopcomputer.and.iphone") ?? UIImage()))
        kategoriList.append(Kategori(adi: "Giyim", image: UIImage(named: "tisort1") ?? UIImage()))
        kategoriList[0].urunList = [u2, u3, u4]
        kategoriList[1].urunList = [u1, u5]
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //segue
        performSegue(withIdentifier: "sgKategori", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgKategori" {
            let vc = segue.destination as! KategoriViewController
            vc.kategori = kategoriList[sender as! Int]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategoriList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TVC_Kategori", owner: self, options: nil)?.first as! TVC_Kategori
        cell.lblKategori.text = kategoriList[indexPath.row].adi
        cell.ivKategori.image = kategoriList[indexPath.row].image
        
        return cell
    }
    
    @IBAction func backToMainVC(segue: UIStoryboardSegue) {
        
    }

}



