//
//  InscriptionViewController.swift
//  EFD
//
//  Created by Gabriel on 1/28/24.
//

import UIKit

class InscriptionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var buttonInscription: UIButton!
    @IBOutlet weak var buttonConnexion: UIButton!
    
    @IBOutlet weak var labelInscription: UILabel!
    
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    
    @IBOutlet weak var textFieldReturnMessageError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        setupButton()
        setupTextField()
        
        labelInscription.text = NSLocalizedString("Sign up", comment: "")
        
        textFieldUsername.placeholder = NSLocalizedString("Username", comment: "")
        textFieldEmail.placeholder = NSLocalizedString("Email", comment: "")
        textFieldPassword.placeholder = NSLocalizedString("Password", comment: "")
        textFieldConfirmPassword.placeholder = NSLocalizedString("Confirm password", comment: "")
        
        buttonInscription.setTitle(NSLocalizedString("Sign up", comment: ""), for: .normal)
        buttonConnexion.setTitle(NSLocalizedString("Log in", comment: ""), for: .normal)
    }
    
    private func setupTextField(){
        textFieldPassword.isSecureTextEntry = true
        textFieldConfirmPassword.isSecureTextEntry = true
        
        textFieldUsername.delegate = self
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        textFieldConfirmPassword.delegate = self
     
        
    }
    
    // Private functions
    private func setupButton(){
        buttonInscription.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
    }


    @IBAction func goToInscription(_ sender: Any) {
        if textFieldUsername.text != "" && textFieldEmail.text != "" && textFieldPassword.text != "" && textFieldConfirmPassword.text != "" && textFieldPassword.text == textFieldConfirmPassword.text{
            
            ConnexionWebServices.addUser(username: textFieldUsername.text!, email: textFieldEmail.text!, password: textFieldPassword.text!){ err, success, user in
                    guard (success != nil) else {
                        return
                    }
                    DispatchQueue.main.async {
                        if success == true {
                            
                            // Stocker un user dans le cache
                            let cache = UserInMemoryService.shared
                            cache.setValue(user!)
                            
                            //let homeViewController = HomeViewController()
                            //self.navigationController?.pushViewController(homeViewController, animated: true)
                            self.textFieldReturnMessageError.text = "L'utilisateur a été ajouté avec succès, veuillez vous connecter."
                            self.textFieldReturnMessageError.textColor = UIColor.green
                        }else{
                            self.textFieldReturnMessageError.text = "Cette utilisateur existe déjà"
                            self.textFieldReturnMessageError.textColor = UIColor.red
                        }
                    }
                    }
        } else {
            self.textFieldReturnMessageError.textColor = UIColor.red
        }

    }
    
    @IBAction func goToConnexionProfile(_ sender: Any) {
        let connexionViewController = ConnexionViewController()
        self.navigationController?.pushViewController(connexionViewController, animated: true)
    }
    
}
