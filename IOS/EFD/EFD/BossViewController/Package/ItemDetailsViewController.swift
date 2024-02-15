//
//  ItemDetailsViewController.swift
//  EFD
//
//  Created by Gabriel on 2/15/24.
//

import UIKit
import MapKit

class ItemDetailsViewController: UIViewController {
    
    @IBOutlet weak var labelPackageName: UILabel!
    @IBOutlet weak var labelPackageStatus: UILabel!
    @IBOutlet weak var labelPackageLocation: UILabel!
    
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelUserMail: UILabel!
    
    @IBOutlet weak var labelDeliveryName: UILabel!
    @IBOutlet weak var labelDeliveryMail: UILabel!
    
    var package : Package!
    
    
    public class func newInstance(package: Package) -> ItemDetailsViewController{
        let idvc = ItemDetailsViewController()
        idvc.package = package
        return idvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelPackageName.text = package.name
        labelPackageStatus.text = "Status du colis: " + package.status
        
        let location = CLLocation(latitude: package.latitude ?? 0, longitude: package.longitude ?? 0)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard var placemark = placemarks?.first else {
                return
            }
            let address = "\(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? ""), \(placemark.locality ?? "") \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
            
            self.labelPackageLocation.text = "Adresse: " + address
            
        }
        locationUser(latitude: package.latitude ?? 0, longitude: package.latitude ?? 0, preLabelText: "Adresse: ", labelText: labelPackageLocation)
        
        if !package.idUserClient.isEmpty{
            DeliveryWebServices.getDeliveryUnique(id: package.idUserClient) { err, success, user  in
                DispatchQueue.main.async {
                    if let user = user {
                        self.labelUserName.text = "Client: " + user.name
                        self.labelUserMail.text = "Mail du client: " + user.email
                        
                    }
                }
            }
        }else {
            labelUserName.isHidden = true
            labelUserMail.isHidden = true
        }
        
        if !package.idUserDelivery!.isEmpty {
            print("okk12")
            DeliveryWebServices.getDeliveryUnique(id: package.idUserDelivery!) { err, success, user  in
                DispatchQueue.main.async { [self] in
                    if let user = user {
                        labelDeliveryName.text = "Livreur: " + user.name
                        labelDeliveryMail.text = "Mail du livreur: " + user.email
                        
                    }
                }
            }
        }else {
            print("okk1")
            labelDeliveryName.isHidden = true
            labelDeliveryMail.isHidden = true
        }
        
        
        
        
    }
    
    func locationUser(latitude: Double, longitude: Double, preLabelText: String, labelText: UILabel) -> Void {
        
        let location = CLLocation(latitude: latitude , longitude: longitude )
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard var placemark = placemarks?.first else {
                return
            }
            let address = "\(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? ""), \(placemark.locality ?? "") \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
            if latitude == 0, longitude == 0{
                labelText.isHidden = true
            }else {
                labelText.text = preLabelText + address
            }
            
            
        }
    }
    
}
