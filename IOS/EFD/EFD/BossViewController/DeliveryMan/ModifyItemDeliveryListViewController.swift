//
//  ModifyItemDeliveryListViewController.swift
//  EFD
//
//  Created by Gabriel on 2/5/24.
//

import UIKit

class ModifyItemDeliveryListViewController: UIViewController {

    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldStatus: UITextField!
    
    @IBOutlet weak var labelValidateError: UILabel!
    @IBOutlet weak var buttonModify: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonModify.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        
        
        WritetextField()

    }

    var user : User!
    
    public class func newInstance(user: User) -> ModifyItemDeliveryListViewController {
            let mofifyItemVDelivery = ModifyItemDeliveryListViewController()
            mofifyItemVDelivery.user = user
            return mofifyItemVDelivery
    }
    
    
    @IBAction func goToModifyDelivery(_ sender: Any) {
        if user.name != textFieldUsername.text {
            user.name = textFieldUsername.text ?? user.name
        }
        if user.email != textFieldEmail.text {
            user.email = textFieldEmail.text ?? user.email
        }
        if textFieldPassword.text != "" {
            user.password = textFieldPassword.text ?? user.password
        }
        if user.role != textFieldStatus.text {
            user.role = textFieldStatus.text ?? user.role
        }
            
        EFDWebServices.modifyDelivery(user: user){ err, success in
                        guard (success != nil) else {
                            return
                        }
                        DispatchQueue.main.async {
                            if success == true {
                                self.labelValidateError.text = "Le livreur à bien été modifié."
                                self.labelValidateError.textColor = UIColor.green
                            }else{
                                self.labelValidateError.text = "Une erreur C'est produite"
                                self.labelValidateError.textColor = UIColor.red
                            }
                        }
                    }
        
    }
    
    func WritetextField(){
        textFieldUsername.text = user.name
        textFieldEmail.text = user.email
        textFieldStatus.text = user.role
    }

}
