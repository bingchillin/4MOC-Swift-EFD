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
    
    static func newInstance() -> MapViewController {
        let mapViewController = MapViewController()
        return mapViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.map.delegate = self
        self.map.showsUserLocation = true
        
        UserServices.getAllUsers { error, users in
            if let error = error {
                print("Erreur lors de la récupération des utilisateurs: \(error.localizedDescription)")
                return
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.zoomToLocation(map.userLocation.location)
        
        DeliveryWebServices.getListDelivery() { error, users in
            if let error = error {
                print("Erreur lors de la récupération des livreurs: \(error.localizedDescription)")
                return
            }
            
            if let users = users {
                var userAnnotations: [MKPointAnnotation] = []
                
                for user in users {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: user.latitude ?? 0, longitude: user.longitude ?? 0)
                    annotation.title = user.name
                    
                    let location = CLLocation(latitude: user.latitude ?? 0, longitude: user.longitude ?? 0)
                    
                    let geocoder = CLGeocoder()
                    
                    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                        guard let placemark = placemarks?.first else {
                            return
                        }
                        
                        let address = "\(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? ""), \(placemark.locality ?? "") \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
                        
                        annotation.subtitle = "\(address)"
                    }
                    
                    
                    userAnnotations.append(annotation)
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.map.addAnnotations(userAnnotations)
                }
            }
        }
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
