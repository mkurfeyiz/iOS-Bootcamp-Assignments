//
//  ViewController.swift
//  harita_app
//
//  Created by mkurfeyiz on 28.01.2022.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var scType: UISegmentedControl!
    @IBOutlet var mvMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Need a delegate for custom pin image.
        mvMap.delegate = self
        
        //Hide navbar
        if navigationController != nil {
            navigationController?.navigationBar.isHidden = true
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Pinning locations of selected type after view gets loaded.
        scTypeChanged_VC(scType)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Prevents pinning users location.
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mvMap.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            //Create
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        switch annotation.subtitle {
        case "School":
            annotationView?.image = UIImage(systemName: "graduationcap.fill")
        case "Mosque":
            annotationView?.image = UIImage(systemName: "building.columns.fill")
        case "Post Office":
            annotationView?.image = UIImage(systemName: "mail.fill")
        default:
            break
        }
        
        return annotationView
    }
    
    //Pinning locations for chosen segment index
    @IBAction func scTypeChanged_VC(_ sender: UISegmentedControl) {
        removeAllPins(locationsList: Global.locationsList)
        
        switch scType.selectedSegmentIndex {
        //School
        case 0:
            pinLocations(locationType: .School)
        //Mosque
        case 1:
            pinLocations(locationType: .Mosque)
        //Post Office
        case 2:
            pinLocations(locationType: .PostOffice)
        //All Locations
        case 3:
            pinLocations(locationType: nil)
        default:
            break
        }
    }
    
    //Could use array.filter
    func pinLocations(locationType: locationType?) {
        for location in Global.locationsList {
            if locationType != nil {
                if location.locationType == locationType {
                    pinLocation(location: location)
                }
            } else {
                pinLocation(location: location)
            }
        }
    }
    
    func pinLocation(location: Locations) {
        location.annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: location.location.coordinate.latitude, longitude: location.location.coordinate.longitude)
        location.annotation.title = location.title
        location.annotation.subtitle = location.locationType.rawValue
        location.annotation.coordinate = coordinate
        
        mvMap.addAnnotation(location.annotation)
    }
    
    func removeAllPins(locationsList: [Locations]) {
        
        for location in locationsList {
            mvMap.removeAnnotation(location.annotation)
        }
       
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        //Update the pins after unwind
        scTypeChanged_VC(scType)
    }

}

