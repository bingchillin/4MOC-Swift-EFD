//
//  CreatePackageClientViewController.swift
//  EFD
//
//  Created by Gabriel on 3/3/24.
//

import UIKit

class CreatePackageClientViewController: UIViewController {

    @IBOutlet weak var labelCreate: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldLongitude: UITextField!
    @IBOutlet weak var textFieldLatitude: UITextField!
    
    @IBOutlet weak var buttonCreate: UIButton!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonCreate.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis

        // Récupérer une valeur à partir du cache en utilisant singleton
        let cache = UserInMemoryService.shared

        user = cache.userValue()
    
        
    }
    
    
    @IBAction func goToCreate(_ sender: Any) {
        
        let idUser = user.id!
        
        
        if textFieldName.text != "" && textFieldLongitude.text != "" && textFieldLatitude.text != "" {
            
            
            PackageWebServices.addPackage(idUserClient: idUser, name: textFieldName.text!, longitude: textFieldLongitude.text!, latitude: textFieldLatitude.text!){ err, success in
                    guard (success != nil) else {
                        return
                    }
                    DispatchQueue.main.async {
                        if success == true {
                            self.labelCreate.text = "Le coli à bien été créé."
                            self.labelCreate.textColor = UIColor.green
                        }
                    }
                }
            
        } else {
            self.labelCreate.text = "Tous les champs doivent être remplis."
            self.labelCreate.textColor = UIColor.red
        }
    }
    
    

}
