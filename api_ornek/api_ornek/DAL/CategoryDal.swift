//
//  CategoryDal.swift
//  api_ornek
//
//  Created by mkurfeyiz on 2.02.2022.
//

import Foundation

class CategoryResponse : Codable {
    var status: CStatus!
    var data = [CategoryData]()
}

class CategoryData : Codable {
    var id: Int!
    var parentCategoryId: Int!
    var name: String!
    var imageUrl: String!
    
}
