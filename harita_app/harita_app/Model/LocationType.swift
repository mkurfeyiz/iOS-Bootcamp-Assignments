//
//  LocationType.swift
//  harita_app
//
//  Created by mkurfeyiz on 10.02.2034.
//

import Foundation

enum locationType: String {
    case School = "School"
    case Mosque = "Mosque"
    case PostOffice = "Post Office"
    
    var index: Int {
        switch self {
        case .School : return 0
        case .Mosque : return 1
        case .PostOffice : return 2
        }
    }
    
}
