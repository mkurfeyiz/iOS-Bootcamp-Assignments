//
//  OrnekViewController.swift
//  liste_ornek
//
//  Created by mkurfeyiz on 19.01.2022.
//

import UIKit

class OrnekViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var urunList = [Urun]()

    @IBOutlet var cvUrunList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let u2 = Urun(adi: "iPhone 11", image: UIImage(named: "iphone11")!, eskiFiyat: 10000.0, yeniFiyat: 14000.0, altBaslik: "Apple", aciklama: "Apple - iPhone 11 128 GB")
        let u3 = Urun(adi: "iPhone 13", image: UIImage(named: "iphone13")!, eskiFiyat: 12000.0, yeniFiyat: 16000.0, altBaslik: "Apple", aciklama: "Apple - iPhone 13 256 GB")
        let u4 = Urun(adi: "Redmi Note 9", image: UIImage(named: "xiaomi")!, eskiFiyat: 5000.0, yeniFiyat: 4000.0, altBaslik: "Xiaomi", aciklama: "Apple - iPhone 11 128 GB")
        urunList = [u2, u3, u4, u2, u2]
        cvUrunList.register(UINib(nibName: "CVC_Yontem2", bundle: nil), forCellWithReuseIdentifier: "CVC_Yontem2")
        
        let layout = cvUrunList.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //view.frame.size.width / 2 ile ana viewin boyutlarina erisebiliyoruz.
        let width = (cvUrunList.frame.size.width - 10) / 2
        let height = width * 3 / 2
        //Estimate Size'i none yapman lazim
        layout.itemSize = CGSize(width: width, height: height)
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urunList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let urun = urunList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC_Yontem2", for: indexPath) as! CVC_Yontem2
        
        cell.lblAd.text = urun.adi
        cell.lblEskiFiyat.text = "\(urun.eskiFiyat ?? 0) TL"
        cell.lblYeniFiyat.text = "\(urun.yeniFiyat ?? 0) TL"
        cell.ivUrun.image = urun.image
        
        return cell
    }

}
