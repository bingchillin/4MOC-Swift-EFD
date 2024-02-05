//
//  ItemDeliveryListViewController.swift
//  EFD
//
//  Created by Gabriel on 2/5/24.
//

import UIKit

class ItemDeliveryListViewController: UIViewController {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var buttonModify: UIButton!
    @IBOutlet weak var buttonSeeMap: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text = user.name
        
        buttonModify.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        buttonSeeMap.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        
        
    }
    
    var user : User!
    
    
    public class func newInstance(user: User) -> ItemDeliveryListViewController{
            let itemVDelivery = ItemDeliveryListViewController()
            itemVDelivery.user = user
            return itemVDelivery
    }
    
    @IBAction func goToModify(_ sender: Any) {
        let nextController = ModifyItemDeliveryListViewController.newInstance(user: user!)
        self.navigationController?.pushViewController(nextController, animated: true)
        
    }
    
    @IBAction func goToSeeMap(_ sender: Any) {
    }
    

   

}
