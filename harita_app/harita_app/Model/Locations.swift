//
//  Locations.swift
//  harita_app
//
//  Created by mkurfeyiz on 28.01.2022.
//

import Foundation
import CoreLocation
import MapKit

class Locations {
    
    var location: CLLocation!
    var title: String!
    var locationType: locationType!
    var annotation = MKPointAnnotation()
    
    init() {
        
    }
    
    init(location: CLLocation, title: String, locationType: locationType) {
        self.location = location
        self.title = title
        self.locationType = locationType
        
    }
    
}
