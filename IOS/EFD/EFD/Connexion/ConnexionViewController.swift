//
//  ConnexionViewController.swift
//  EFD
//
//  Created by Gabriel on 1/28/24.
//

import UIKit

class ConnexionViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelError: UILabel!
    
    @IBOutlet weak var buttonConnexion: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        buttonConnexion.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        
        // Configurer le texte du bouton
        buttonConnexion.setTitle("Connexion", for: .normal)
        
        textFieldPassword.isSecureTextEntry = true
        
        

                
    }


    @IBAction func goToConnexion(_ sender: Any) {
        
        if textFieldEmail.text != "" && textFieldPassword.text != "" {
            
            ConnexionWebServices.connectUser(email: textFieldEmail.text!, password: textFieldPassword.text!){ err, success, user in
                    guard (success != nil) else {
                        return
                    }
                    DispatchQueue.main.async {
                        if success == true {
                            
                            // Stocker un user dans le cache
                            let cache = UserInMemoryService.shared
                            cache.setValue(user!)

                            let homeViewController = HomeViewController()
                            self.navigationController?.pushViewController(homeViewController, animated: true)
                        }else{
                            self.labelError.text = "L'email et le password ne correspondent pas"
                            self.labelError.textColor = UIColor.red
                        }
                        
                    }
            }
        }else{
            self.labelError.textColor = UIColor.red
        }
        
    }
    
    @IBAction func goToInscription(_ sender: Any) {
        let inscriptionViewController = InscriptionViewController()
        self.navigationController?.pushViewController(inscriptionViewController, animated: true)
    }
    
}
