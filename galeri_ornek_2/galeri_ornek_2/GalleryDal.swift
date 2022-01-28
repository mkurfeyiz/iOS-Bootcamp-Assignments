//
//  GalleryDal.swift
//  galeri_ornek_2
//
//  Created by mkurfeyiz on 26.01.2022.
//

import Foundation
import CoreData
import UIKit

class GalleryDal {
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func getAllImages() -> [ImageTable]? {
        let fetchRequest: NSFetchRequest<ImageTable> = ImageTable.fetchRequest()
        
        
        do {
            return try getContext().fetch(fetchRequest)
        } catch {
            
        }
        
        return nil
    }
    
    static func saveImage(title: String, location: String, desc: String, image: UIImage) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "ImageTable", in: context)
        
        let imageData = NSManagedObject(entity: entity!, insertInto: context)
        
        imageData.setValue(title, forKey: "title")
        imageData.setValue(location, forKey: "location")
        imageData.setValue(desc, forKey: "desc")
        imageData.setValue(image.jpegData(compressionQuality: 0.6), forKey: "image")
        
        do {
            try context.save()
        } catch {
            
        }
        
    }
    
    static func update() {
        try? getContext().save()
    }
    
    static func delete(image: ImageTable) {
        getContext().delete(image)
        try? getContext().save()
    }
}
