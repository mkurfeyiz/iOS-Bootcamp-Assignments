//
//  Kategori.swift
//  liste_ornek
//
//  Created by mkurfeyiz on 18.01.2022.
//

import Foundation
import UIKit

class Kategori {
    let adi: String!
    let image: UIImage!
    var urunList = [Urun]()
    
    init(adi: String, image: UIImage) {
        self.adi = adi
        self.image = image
    }
}
