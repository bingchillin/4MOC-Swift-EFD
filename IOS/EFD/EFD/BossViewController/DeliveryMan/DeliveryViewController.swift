//
//  DeliveryViewController.swift
//  EFD
//
//  Created by Gabriel on 2/2/24.
//

import UIKit
import CoreLocation

class DeliveryViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    var userLocation: CLLocationCoordinate2D?

    @IBOutlet weak var buttonCDM: UIButton!
    
    
    @IBOutlet weak var tableViewDelivery: UITableView!
    
    @IBOutlet weak var labelEmptyUser: UILabel!
    
    
    @IBOutlet weak var ButtonMap: UIButton!
    
    var userList = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide back button
        self.navigationItem.hidesBackButton = true
        
        buttonCDM.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        ButtonMap.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        
        tableViewDelivery.delegate = self
        tableViewDelivery.dataSource = self
        tableViewDelivery.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        
        DeliveryWebServices.getListDelivery() { err, users in
                
                DispatchQueue.main.async {
                    if let users = users {
                        self.labelEmptyUser.textColor = UIColor.white
                        self.labelEmptyUser.isHidden = true
                        self.userList = users
                        self.tableViewDelivery.reloadData()
                    }
                    else{
                        self.labelEmptyUser.textColor = UIColor.black
                        self.labelEmptyUser.isHidden = false
                        self.tableViewDelivery.isHidden = true
                    }
                    
                    
                }
       
        }

      
    }
    
   
    
    

    @IBAction func goToCreateDeliveryMan(_ sender: Any) {
        let cdmViewController = CreateDeliveryManViewController()
        self.navigationController?.pushViewController(cdmViewController, animated: true)
    }
    
    @IBAction func goToMap(_ sender: Any) {
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
        
        let mapViewController = MapViewController()
                navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    
    @IBAction func goToBack(_ sender: Any) {
        let nextController = HomeViewController()
        self.navigationController?.pushViewController(nextController, animated: true)
    }

}

extension DeliveryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userId = self.userList[indexPath.row].id
        DeliveryWebServices.getDeliveryUnique(id: userId!){err, success, user in
            guard err == nil else {
                return
            }
            guard (success != nil) else {
                return
            }
            DispatchQueue.main.async {
                let nextController = ItemDeliveryListViewController.newInstance(user: user!)
                self.navigationController?.pushViewController(nextController, animated: true)
            }
            }
            
        
    }
}

extension DeliveryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        
        let cell = tableViewDelivery.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = userList[indexPath.row].name
        cell.layer.shadowColor = UIColor(red: 58.0/255, green: 73.0/255, blue: 89.0/255, alpha: 1).cgColor
        //cell.layer.shadowOffset = CGSize(width: 2.0, height: 10)
        //cell.layer.shadowOpacity = 4.0
        
       
        return cell
    }
}

extension DeliveryViewController: CLLocationManagerDelegate {
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
