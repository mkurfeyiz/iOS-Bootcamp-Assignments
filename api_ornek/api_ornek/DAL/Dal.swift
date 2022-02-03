//
//  Dal.swift
//  api_ornek
//
//  Created by mkurfeyiz on 2.02.2022.
//

import Foundation

class CResponse : Codable {
    var status: CStatus!
    var data: LoginData!
}

class CStatus : Codable {
    var code: Int!
    var value: String!
}

class LoginData : Codable {
    var languageId: Int!
    var token: String!
    var phone: String!
    var socialRememberToken: Int!
}
