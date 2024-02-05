//
//  DeliveryViewController.swift
//  EFD
//
//  Created by Gabriel on 2/2/24.
//

import UIKit

class DeliveryViewController: UIViewController {

    @IBOutlet weak var buttonCDM: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonCDM.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis

      
    }

    @IBAction func goToCreateDeliveryMan(_ sender: Any) {
        let cdmViewController = CreateDeliveryManViewController()
        self.navigationController?.pushViewController(cdmViewController, animated: true)
    }
    

}
