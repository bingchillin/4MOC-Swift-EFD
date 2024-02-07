//
//  HomeViewController.swift
//  EFD
//
//  Created by Gabriel on 1/28/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var buttonDeliveryMan: UIButton!
    @IBOutlet weak var labelRound: UILabel!
    
    
    var user : User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide back button
        self.navigationItem.hidesBackButton = true
        
        // Récupérer une valeur à partir du cache en utilisant singleton
        let cache = UserInMemoryService.shared

        user = cache.userValue()
        
        print(user.email,user.name, user.role, "OK")
        
        
        
        buttonDeliveryMan.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        
        showBoss()
        

    }
    
    
    
    
    
    
    
    @IBAction func goToDeliveryMan(_ sender: Any) {
        let dmViewController = DeliveryViewController()
        self.navigationController?.pushViewController(dmViewController, animated: true)
    }
    
    public func showBoss() -> Void {
       
        
        
        if user.role == "admin" {
            buttonDeliveryMan.isHidden = false
            labelRound.isHidden = false
        }
        
    }
    

}
