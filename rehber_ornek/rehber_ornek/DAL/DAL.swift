//
//  DAL.swift
//  rehber_ornek
//
//  Created by mkurfeyiz on 25.01.2022.
//

import Foundation
import CoreData
import UIKit

class DAL {
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func update() {
        try? getContext().save()
        
    }
}
