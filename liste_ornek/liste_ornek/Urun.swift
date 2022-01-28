//
//  Urun.swift
//  liste_ornek
//
//  Created by mkurfeyiz on 18.01.2022.
//

import Foundation
import UIKit

class Urun {
    let adi: String! // baslik
    let image: UIImage!
    let eskiFiyat: Double!
    let yeniFiyat: Double!
    let altBaslik: String!
    let aciklama: String!
    
    init(adi: String, image: UIImage, eskiFiyat: Double, yeniFiyat: Double, altBaslik: String, aciklama: String){
        self.adi = adi
        self.image = image
        self.eskiFiyat = eskiFiyat
        self.yeniFiyat = yeniFiyat
        self.altBaslik = altBaslik
        self.aciklama = aciklama
    }
}
