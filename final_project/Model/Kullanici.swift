//
//  Kullanici.swift
//  final_project
//
//  Created by mkurfeyiz on 3.02.2022.
//

import Foundation

class Kullanici {
    var ad: String!
    var soyad: String!
    var email: String!
    var telefon: String!
    var sifre: String!
    var tip: String!
    var tanitim: String?
    var hizmet = [Hizmet]()
    
    init() {
        
    }
    
    init(ad: String, soyad: String, telefon: String, email: String, sifre: String, tip: String, tanitim: String?) {
        self.ad = ad
        self.soyad = soyad
        self.telefon = telefon
        self.email = email
        self.sifre = sifre
        self.tip = tip
        self.tanitim = tanitim
    }
}
