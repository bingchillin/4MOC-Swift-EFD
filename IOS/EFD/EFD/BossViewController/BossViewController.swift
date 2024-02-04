//
//  BossViewController.swift
//  EFD
//
//  Created by Mohamed El Fakharany on 04/02/2024.
//

import UIKit
import CoreLocation

class BossViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    var userLocation: CLLocationCoordinate2D?

    @IBAction func handleNext(_ sender: Any) {
        let mapViewController = MapViewController.newInstance()
        navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    @IBAction func accessLocation(_ sender: Any) {
        if self.locationManager == nil {
            print("test")
            // premier clic sur le bouton gps
            let manager = CLLocationManager()
            manager.delegate = self
            
            if CLLocationManager.authorizationStatus() == .notDetermined {
                manager.requestWhenInUseAuthorization()
            }
            
            self.locationManager = manager // obligatoire de mémoriser la variable sinon cancel la geoloc
        } else {
            self.handleLocationManagerStatus(self.locationManager!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension BossViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last?.coordinate
        manager.stopUpdatingLocation() // arrête la geoloc
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
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
