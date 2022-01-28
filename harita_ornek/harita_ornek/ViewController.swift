//
//  ViewController.swift
//  harita_ornek
//
//  Created by mkurfeyiz on 28.01.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet var mkMap: MKMapView!
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var txtvDesc: UITextView!
    
    var annotation: MKPointAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let touchdownGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.selectLocation(_:)))
        touchdownGesture.minimumPressDuration = 0.5
        mkMap.addGestureRecognizer(touchdownGesture)
    }
    
    @objc func selectLocation(_ sender: UILongPressGestureRecognizer) {
        if annotation != nil {
            mkMap.removeAnnotation(self.annotation)
        }
        
        let touchLocation = sender.location(in: mkMap)
        let coordinate = mkMap.convert(touchLocation, toCoordinateFrom: mkMap)
        self.annotation = MKPointAnnotation()
        self.annotation.coordinate = coordinate
        
        mkMap.addAnnotation(self.annotation)
    }

    @IBAction func btnShow_TUI(_ sender: UIButton) {
        info(message: "Latitude : \(self.annotation?.coordinate.latitude ?? 0)\nLongitude : \(self.annotation?.coordinate.longitude ?? 0)\nTitle : \(self.tfTitle.text ?? "")\nDescription : \(self.txtvDesc.text ?? "")")
    }
    
    func info(message: String) {
        let ac = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }
    
}

