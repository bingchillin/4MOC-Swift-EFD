//
//  HomeViewController.swift
//  EFD
//
//  Created by Gabriel on 1/28/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // hide back button
        self.navigationItem.hidesBackButton = true
        
        print(user.email,user.name, user.role)

    }
    
    
    var user : User!
    
    
    public class func newInstance(user: User) -> HomeViewController{
            let homeV = HomeViewController()
            homeV.user = user
            return homeV
    }

    

}
