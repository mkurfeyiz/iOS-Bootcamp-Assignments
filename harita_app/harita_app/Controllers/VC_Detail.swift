//
//  VC_Detail.swift
//  harita_app
//
//  Created by mkurfeyiz on 28.01.2022.
//

import UIKit
import MapKit

class VC_Detail: UIViewController {

    @IBOutlet var mvMap: MKMapView!
    @IBOutlet var tfTitle: UITextField!
    
    @IBOutlet var btnSchool: UIButton!
    @IBOutlet var btnMosque: UIButton!
    @IBOutlet var btnPostOffice: UIButton!
    
    var annotation: MKPointAnnotation!
    var locationType: locationType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(_:)))
        longPressGesture.minimumPressDuration = 0.8
        mvMap.addGestureRecognizer(longPressGesture)
    }
    
    @objc func chooseLocation(_ sender: UILongPressGestureRecognizer) {
        if annotation != nil {
            mvMap.removeAnnotation(self.annotation)
        }
        
        let touchLocation = sender.location(in: mvMap)
        let coordinate = mvMap.convert(touchLocation, toCoordinateFrom: mvMap)
        self.annotation = MKPointAnnotation()
        self.annotation.coordinate = coordinate
        
        mvMap.addAnnotation(self.annotation)
    }
    
    @IBAction func btnSaveLocation_TUI(_ sender: UIButton) {
        //Checks for any empty value
        if tfTitle.text?.isEmpty ?? true || self.locationType == nil || self.annotation?.coordinate == nil {
            //Alert func
            alert()
        } else {
            let location = CLLocation(latitude: self.annotation.coordinate.latitude, longitude: self.annotation.coordinate.longitude)
            
            Global.locationsList.append(Locations(location: location , title: tfTitle.text!, locationType: self.locationType))
            
            //Note : Dont use another segue for going back to main page since it creates a new view
            //and it doesnt destroy the first view. As a result, we will have more than 1 main view
            //if we use this method. And this causes device to use much more memory
            //then it should be. After fixing the code, our apps memory usage has decreased to
            //108,1 MB usage.
            performSegue(withIdentifier: "unwindFromDetail", sender: nil)
        }
    }
    
    @IBAction func btnSetSchool_TUI(_ sender: UIButton) {
        self.locationType = .School
        sender.backgroundColor = .lightGray
        btnMosque.backgroundColor = .white
        btnPostOffice.backgroundColor = .white
    }
    
    @IBAction func btnSetMosque_TUI(_ sender: UIButton) {
        self.locationType = .Mosque
        sender.backgroundColor = .lightGray
        btnSchool.backgroundColor = .white
        btnPostOffice.backgroundColor = .white
    }
    
    @IBAction func btnSetPostOffice_TUI(_ sender: UIButton) {
        self.locationType = .PostOffice
        sender.backgroundColor = .lightGray
        btnSchool.backgroundColor = .white
        btnMosque.backgroundColor = .white
    }

    func alert() {
        let ac = UIAlertController(title: "Empty Fields", message: "All fields must be filled.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }
}
