//
//  LocationManagerExtension.swift
//  EFD
//
//  Created by Mohamed El Fakharany on 12/02/2024.
//

import CoreLocation
import UIKit

extension UIViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last?.coordinate
        manager.stopUpdatingLocation() // arrête la geoloc
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.handleLocationManagerStatus(manager)
    }
    
    func handleLocationManagerStatus(_ locationManager: CLLocationManager) {
        let status = CLLocationManager.authorizationStatus()
        if status == .restricted || status == .denied {
            self.displayDeniedMessage()
        } else if status == .authorizedWhenInUse {
            self.retrieveGPSCoordinate(locationManager)
        }
    }
    
    func retrieveGPSCoordinate(_ locationManager: CLLocationManager) {
        locationManager.startUpdatingLocation() // démarre l'écoute de gps
    }
    
    func displayDeniedMessage() {
        let alert = UIAlertController(title: "Location access denied", message: "Location is needed for a functional app !", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ouvrir les préférences", style: .destructive))
        self.present(alert, animated: true)
    }
}
