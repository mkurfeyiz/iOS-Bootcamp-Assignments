//
//  ViewController.swift
//  galeri_ornek_2
//
//  Created by mkurfeyiz on 26.01.2022.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var cvGallery: UICollectionView!
    var imageList = [ImageTable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvGallery.register(UINib(nibName: "CVC_Image", bundle: nil), forCellWithReuseIdentifier: "CVC_Image")
        
        imageList = GalleryDal.getAllImages() ?? []
        
        setLayout()
        
    }
    
    func setLayout() {
        let layout = cvGallery.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let cvWidth = (cvGallery.frame.size.width - 35) / 3.0
        let cvHeight = cvWidth
        layout?.itemSize = CGSize(width: cvWidth, height: cvHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //segue
        performSegue(withIdentifier: "sgUpdate", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgUpdate" {
            let vc = segue.destination as! VC_Detail
            
            vc.image = imageList[sender as! Int]
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC_Image", for: indexPath) as! CVC_Image
        
        cell.ivImage.image = UIImage(data: imageList[indexPath.row].image!)
        cell.ivImage.contentMode = UIView.ContentMode.scaleToFill
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        cvGallery.reloadData()
    }

}

