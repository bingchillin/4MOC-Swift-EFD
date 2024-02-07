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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide back button
        self.navigationItem.hidesBackButton = true
        
        print(user.email,user.name, user.role)
        
        
        buttonDeliveryMan.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        
        showBoss()

    }
    
    
    var user : User!
    
    
    public class func newInstance(user: User) -> HomeViewController{
            let homeV = HomeViewController()
            homeV.user = user
            return homeV
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
