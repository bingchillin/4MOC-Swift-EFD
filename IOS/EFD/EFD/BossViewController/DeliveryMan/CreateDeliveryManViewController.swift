//
//  CreateDeliveryManViewController.swift
//  EFD
//
//  Created by Gabriel on 2/2/24.
//

import UIKit

class CreateDeliveryManViewController: UIViewController {
    
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    
    @IBOutlet weak var labelStatus: UILabel!
    
    @IBOutlet weak var buttonToCreateD: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide back button
        self.navigationItem.hidesBackButton = true
        
        buttonToCreateD.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        

        // Do any additional setup after loading the view.
    }

    
    @IBAction func goToCreateD(_ sender: Any) {
        if textFieldUsername.text != "" && textFieldEmail.text != "" && textFieldPassword.text != "" && textFieldConfirmPassword.text != ""{
            
            if textFieldPassword.text == textFieldConfirmPassword.text{
                
                DeliveryWebServices.addDelivery(username: textFieldUsername.text!, email: textFieldEmail.text!, password: textFieldPassword.text!){ err, success in
                        guard (success != nil) else {
                            return
                        }
                        DispatchQueue.main.async {
                            if success == true {
                                self.labelStatus.text = "Le livreur à bien été créé."
                                self.labelStatus.textColor = UIColor.green
                            }else{
                                self.labelStatus.text = "Cette utilisateur existe déjà"
                                self.labelStatus.textColor = UIColor.red
                            }
                        }
                    }
            }else {
                self.labelStatus.text = "Les mots de passe ne correspondent pas."
                self.labelStatus.textColor = UIColor.red
            }
        } else {
            self.labelStatus.text = "Tous les champs doivent être remplis."
            self.labelStatus.textColor = UIColor.red
        }
    }
    
    @IBAction func goToBack(_ sender: Any) {
        let nextController = DeliveryViewController()
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
   

}
