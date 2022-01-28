//
//  ViewController.swift
//  galeri_ornek
//
//  Created by mkurfeyiz on 19.01.2022.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var cvImage: UICollectionView!
    @IBOutlet var ivSelectedImage: UIImageView!
    @IBOutlet var btnKapat: UIButton!
    
    var imageList = [UIImage]()
    var cvWidth: Double!
    var cvHeight: Double!
    var layout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ivSelectedImage.isHidden = true
        btnKapat.isHidden = true
        
        cvImage.register(UINib(nibName: "CVC_Resimler", bundle: nil), forCellWithReuseIdentifier: "CVC_Resimler")
        for i in 0...9 {
            if i % 2 == 0 {
                imageList.append(UIImage(named: "iphone13") ?? UIImage())
            } else {
                imageList.append(UIImage(systemName: "iphone") ?? UIImage())
            }
            
        }
        
        self.layout = cvImage.collectionViewLayout as? UICollectionViewFlowLayout
        self.layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.cvWidth = cvImage.frame.size.width < CGFloat(500) ? ((cvImage.frame.size.width - 14.0) / 2.0) : ((cvImage.frame.size.width - 14.0) / 4.0)
        self.cvHeight = self.cvWidth * 3 / 2
        self.layout.itemSize = CGSize(width: CGFloat(self.cvWidth), height: CGFloat(self.cvHeight))
        
    }
    
    //Telefonun rotate aksiyonunu yakaladigi yer
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //Bu kod ile rotasyon islemi tamamlandiktan sonra width ve height degerlerini
        //yeniden hesapliyoruz.
        //burada animasyon ile yakalamaktansa viewDidLoadda sabit olarak landscape ve
        //portrait mod icin genislik ve yukseklik ayarlanip bu fonk icinde tanimlanmis
        //width/height verilebilirdi. (ss mevcut)
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            let width = self.cvImage.frame.size.width
            self.cvWidth = width < CGFloat(500) ? ((width - 14.0) / 2.0) : ((width - (14.0 * 4) ) / 4.0)
            self.cvHeight = self.cvWidth * 3 / 2
            self.layout.itemSize = CGSize(width: CGFloat(self.cvWidth), height: CGFloat(self.cvHeight))
        }
        
    }

    @IBAction func btnResmiKapat_TUI(_ sender: UIButton) {
        ivSelectedImage.isHidden = true
        btnKapat.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        ivSelectedImage.image = imageList[indexPath.row]
        ivSelectedImage.isHidden = false
        btnKapat.isHidden = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC_Resimler", for: indexPath) as! CVC_Resimler
        
        cell.ivImage.image = imageList[indexPath.row]
        
        return cell
    }

}

