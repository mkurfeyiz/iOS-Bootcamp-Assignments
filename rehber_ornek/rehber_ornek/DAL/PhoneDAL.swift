//
//  PhoneDAL.swift
//  rehber_ornek
//
//  Created by mkurfeyiz on 24.01.2022.
//

import Foundation
import CoreData
import UIKit

class PhoneDAL : DAL {
    
    static func getPhonesByContactId(ownerId: UUID) -> [PhonesTable]? {
        let fetchRequest: NSFetchRequest<PhonesTable> = PhonesTable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "ownerId == %@", ownerId as CVarArg)
        
        do {
            return try getContext().fetch(fetchRequest)
        } catch {
            
        }
        
        return nil
    }
    
    static func savePhone(ownerId: UUID, phone: String) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "PhonesTable", in: context)
        
        let phoneData = NSManagedObject(entity: entity!, insertInto: context)
        
        phoneData.setValue(ownerId, forKey: "ownerId")
        phoneData.setValue(phone, forKey: "phone")
        
        do {
            try context.save()
        } catch {
            print("error")
        }
        
    }
    
    //Burada sildikten sonra hemen save yaptirdigimizda, ekranda save e basmasak da tel
    //silinir. Bu sebeple yorum satirina alinabilir
    static func deletePhone(phone: PhonesTable) {
        getContext().delete(phone)
        try? getContext().save()
    }
}
