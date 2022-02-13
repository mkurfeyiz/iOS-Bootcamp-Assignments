//
//  Globals.swift
//  final_project
//
//  Created by mkurfeyiz on 7.02.2022.
//

import Foundation
import FirebaseAuth

class Globals {
    static func logoutAlert(_ viewController: UIViewController) {
        let alert = UIAlertController(title: "Çıkış yapmak istediğinizden emin misin?", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Çıkış Yap" , style: UIAlertAction.Style.destructive, handler: { (action) in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                UserDefaults.standard.removeObject(forKey: "tip")
                UserDefaults.standard.synchronize()
                
                if let storyboard = viewController.storyboard {
                    let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
                    vc.modalPresentationStyle = .fullScreen
                    viewController.present(vc, animated: false, completion: nil)

                }
            } catch let signOutError as NSError {
                print("error",signOutError)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "İptal", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
