//
//  ContactDAL.swift
//  rehber_ornek
//
//  Created by mkurfeyiz on 24.01.2022.
//

import Foundation
import CoreData
import UIKit

class ContactDAL : DAL {
    
    static func getAllContacts() -> [ContactTable]? {
        let fetchRequest: NSFetchRequest<ContactTable> = ContactTable.fetchRequest()
        
        do {
            return try getContext().fetch(fetchRequest)
        } catch {
            
        }
        
        return nil
    }
    
    static func saveContact(fname: String, lname: String, image: UIImage?) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "ContactTable", in: context)
        
        let contact = NSManagedObject(entity: entity!, insertInto: context)
        let uuid = UUID().uuidString
        let photo = image?.pngData()
        
        contact.setValue(NSUUID(uuidString: uuid), forKey: "id")
        contact.setValue(fname, forKey: "firstName")
        contact.setValue(lname, forKey: "lastName")
        contact.setValue(photo, forKey: "photo")
        
        print(uuid)
        do {
            try context.save()
        } catch {
            
        }
        
    }
    
    static func deleteContact(contact: ContactTable) {
        getContext().delete(contact)
        try? getContext().save()
    }
    
}
