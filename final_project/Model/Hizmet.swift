//
//  Hizmet.swift
//  final_project
//
//  Created by mkurfeyiz on 3.02.2022.
//

import Foundation

class Hizmet {
    var id: String!
    var baslik: String!
    var aciklama: String!
    var kullanici: Kullanici?
    
    init() {
        self.baslik = ""
        self.aciklama = ""
    }
    
    init(baslik: String, aciklama: String) {
        self.baslik = baslik
        self.aciklama = aciklama
    }
}
