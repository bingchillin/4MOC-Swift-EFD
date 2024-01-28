//
//  InscriptionViewController.swift
//  EFD
//
//  Created by Gabriel on 1/28/24.
//

import UIKit

class InscriptionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var buttonInscription: UIButton!
    
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    
    @IBOutlet weak var textFieldReturnMessageError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        setupTextField()
        
    }
    
    private func setupTextField(){
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
            
            EFDWebServices.addUser(username: textFieldUsername.text!, email: textFieldEmail.text!, password: textFieldPassword.text!){ err, success in
                    guard (success != nil) else {
                        return
                    }
                    DispatchQueue.main.async {
                        let homeViewController = HomeViewController()
                        self.navigationController?.pushViewController(homeViewController, animated: true)
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
