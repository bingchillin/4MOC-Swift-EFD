//
//  MapViewController.swift
//  EFD
//
//  Created by Mohamed El Fakharany on 04/02/2024.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    var user = User(name: "Livreur 1", email: "", password: "", role: "livreur")
    
    static func newInstance() -> MapViewController {
        let mapViewController = MapViewController()
        return mapViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.map.delegate = self
        self.map.showsUserLocation = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.zoomToLocation(map.userLocation.location)
        
        var livreurs: [MKPointAnnotation] = []
        
        for i in 1 ... 1 {
            let point = MKPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: 48.84, longitude: 2.38)
            point.title = "Livreur \(i)"
            point.subtitle = "\(point.coordinate.latitude), \(point.coordinate.longitude)"
                
                livreurs.append(point)
        }
        self.map.addAnnotations(livreurs)
    }

    func zoomToLocation(_ location: CLLocation?) {
        guard let loc = location else {
            return
        }
        var maxDistance: CLLocationDistance = 0
        for annotation in self.map.annotations {
            if annotation is MKUserLocation {
                continue
            }
            let annotationLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            let distance = loc.distance(from: annotationLocation)
            if distance > maxDistance {
                maxDistance = distance
            }
        }
        self.map.setRegion(MKCoordinateRegion(center: loc.coordinate, latitudinalMeters: maxDistance * 2, longitudinalMeters: maxDistance * 2), animated: true)
    }
    
    func randomCoordinatesGen(userLatitude: Double, userLongitude: Double) -> CLLocationCoordinate2D {
        let randomLatitude = Double.random(in: 0.0027 ... 0.009) + userLatitude
        let randomLongitude = Double.random(in: 0.0027 ... 0.009) + userLongitude
        
        return CLLocationCoordinate2D(latitude: randomLatitude, longitude: randomLongitude)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: "Livreur")
        if pin == nil {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Livreur")
            pin!.canShowCallout = true
        } else {
            pin!.annotation = annotation
        }
        return pin
    }
}

