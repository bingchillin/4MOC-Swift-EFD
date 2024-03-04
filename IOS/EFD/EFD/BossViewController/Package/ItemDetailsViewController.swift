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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewAdmin: UIImageView!
   
    @IBOutlet weak var labelNoPicture: UILabel!
    @IBOutlet weak var buttonValidate: UIButton!
    
    @IBOutlet weak var buttonError: UIButton!

    @IBOutlet weak var buttonPackValidate: UIButton!
    
    
    var package : Package!
    var user: User!
    var savePicture: Bool = false
    var fileUrlSave: String!
    
    
    public class func newInstance(package: Package) -> ItemDetailsViewController{
        let idvc = ItemDetailsViewController()
        idvc.package = package
        return idvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let cache = UserInMemoryService.shared
        user = cache.userValue()
        
        displayD()
        displayDet()
        displayI()
        displayClient()
        
        
        
        
        
    }
    
    func displayD(){
        if user.role == "livreur" {
            self.navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(openCamera)),
                UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(openLibrary))
            ]
            self.imageView.layer.borderWidth = 2
            self.imageView.layer.borderColor = UIColor.black.cgColor
            self.imageView.layer.backgroundColor = UIColor.white.cgColor
            buttonValidate.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
            buttonValidate.isHidden = false
            imageView.isHidden = false
        }
        else if user.role == "admin" || user.role == "client" {
            imageViewAdmin.isHidden = false
        }
        
    }
    
    func displayDet(){
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
            DeliveryWebServices.getDeliveryUnique(id: package.idUserDelivery!) { err, success, user  in
                DispatchQueue.main.async { [self] in
                    if let user = user {
                        labelDeliveryName.text = "Livreur: " + user.name
                        labelDeliveryMail.text = "Mail du livreur: " + user.email
                        
                    }
                }
            }
        }else {
            labelDeliveryName.isHidden = true
            labelDeliveryMail.isHidden = true
        }
    }
    
    func displayI() {
        if user.role == "admin" || user.role == "client" {
            if !package.proof.isEmpty {
                // Spécifiez le chemin complet de l'image
                let imagePath = package.proof
                
                // Chargez l'image à partir du chemin spécifié
                if let image = UIImage(contentsOfFile: imagePath) {
                    // Afficher l'image dans votre UIImageView
                    imageViewAdmin.image = image
                } else {
                    print("Erreur: Impossible de charger l'image.")
                }
            }
            else {
                labelNoPicture.isHidden = false
            }
        }
        
        

    }
    
    func displayClient() {
        if user.role == "client" {
            buttonError.isHidden = false
            buttonPackValidate.isHidden = false
            
        }
    }
    
    @IBAction func goToPackValidate(_ sender: Any) {
        let alertVerif = UIAlertController(title: "Demande de validation", message: "Ce colis vous est bien arrivé ?", preferredStyle: .alert)
        
        // Action "Oui"
        alertVerif.addAction(UIAlertAction(title: "Oui", style: .default, handler: { _ in
           
            PackageWebServices.modifyStatusPackageC(idP: self.package.id, status: "close"){ err, success in
                    guard (success != nil) else {
                        return
                    }
                    DispatchQueue.main.async {
                        if success == true {
                            let alert = UIAlertController(title: "Validation executée", message: "La validation a bien été effectuée", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Fermer", style: .cancel, handler: { _ in
                                let hViewController = HomeViewController()
                                self.navigationController?.pushViewController(hViewController, animated: true)
                            }))
                            self.present(alert, animated: true)
                            

                        }else{
                            let alertError = UIAlertController(title: "Suppression impossible", message: "Error: suppression impossible", preferredStyle: .alert)
                            alertError.addAction(UIAlertAction(title: "Fermer", style: .cancel))
                            self.present(alertError, animated: true)
                        }
                        
                    }
            }
        }))

        // Action "Non"
        alertVerif.addAction(UIAlertAction(title: "Non", style: .cancel))
        self.present(alertVerif, animated: true)
    }
    
    @IBAction func goToError(_ sender: Any) {
        let alertVerif = UIAlertController(title: "Demande de validation", message: "Etes vous sur de vouloir mentiionné une erreur sur ce coli ?", preferredStyle: .alert)
        
        // Action "Oui"
        alertVerif.addAction(UIAlertAction(title: "Oui", style: .default, handler: { _ in
           
            PackageWebServices.modifyStatusPackageC(idP: self.package.id, status: "error"){ err, success in
                    guard (success != nil) else {
                        return
                    }
                    DispatchQueue.main.async {
                        if success == true {
                            let alert = UIAlertController(title: "Erreur validée", message: "L'erreur a bien été prise en compte, nous reviendrons vers vous", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Fermer", style: .cancel, handler: { _ in
                                let hViewController = HomeViewController()
                                self.navigationController?.pushViewController(hViewController, animated: true)
                            }))
                            self.present(alert, animated: true)
                            

                        }else{
                            let alertError = UIAlertController(title: "Suppression impossible", message: "Error: suppression impossible", preferredStyle: .alert)
                            alertError.addAction(UIAlertAction(title: "Fermer", style: .cancel))
                            self.present(alertError, animated: true)
                        }
                        
                    }
            }
        }))

        // Action "Non"
        alertVerif.addAction(UIAlertAction(title: "Non", style: .cancel))
        self.present(alertVerif, animated: true)
    }
    
    
    @objc func openCamera(){
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker,animated: true)
    }
    
    @objc func openLibrary(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker,animated: true)
        
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
    
    @IBAction func goToHome(_ sender: Any) {
        if savePicture == false {
            let alert = UIAlertController(title: "Success Impossible", message: "Vous devez prendre une photo pour valider un coli", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Fermer", style: .cancel))
            self.present(alert, animated: true)
        }else {
            PackageWebServices.modifySavePackage(idP: package.id, proof: fileUrlSave){err, success in
                guard err == nil else {
                    return
                }
                guard (success != nil) else {
                    return
                }
                
            }
            let nextController = HomeViewController()
            self.navigationController?.pushViewController(nextController, animated: true)
        }
        
    }
    
    
}

extension ItemDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else{
            return
        }
        // Définir le chemin du répertoire de destination
       let directoryURL = URL(fileURLWithPath: "/Users/gabriel/Documents/ESGI/QuatriemeAnnee/IOS/projectExam/picture")
       
       // Créer le nom du fichier
       let fileName = "image_\(Date().timeIntervalSince1970).jpg"
       
       // Créer le chemin complet pour le fichier
       let fileURL = directoryURL.appendingPathComponent(fileName)
       
       // Convertir l'image en données JPEG et écrire dans le fichier
       if let imageData = image.jpegData(compressionQuality: 1.0) {
           do {
               // Créer le répertoire s'il n'existe pas déjà
               try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
               
               // Écrire les données de l'image dans le fichier
               try imageData.write(to: fileURL)
               
               // Afficher le chemin dans les logs
               savePicture = true
               fileUrlSave = fileURL.path
               print("Chemin de l'image enregistrée : \(fileURL.path)")
               
           } catch {
               print("Erreur lors de l'enregistrement de l'image : \(error)")
           }
       }
        
        self.imageView.image = image
        
        picker.dismiss(animated: true) // Enleve le picker
    }
        
}

