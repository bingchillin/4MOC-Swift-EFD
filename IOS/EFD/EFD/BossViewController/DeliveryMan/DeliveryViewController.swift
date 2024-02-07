//
//  DeliveryViewController.swift
//  EFD
//
//  Created by Gabriel on 2/2/24.
//

import UIKit

class DeliveryViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var buttonCDM: UIButton!
    
    
    @IBOutlet weak var tableViewDelivery: UITableView!
    
    var userList = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide back button
        self.navigationItem.hidesBackButton = true
        
        
        buttonCDM.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        
        tableViewDelivery.delegate = self
        tableViewDelivery.dataSource = self
        tableViewDelivery.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
            
        
        
        DeliveryWebServices.getListDelivery() { err, users in
                
                DispatchQueue.main.async {
                    if let users = users {
                        self.userList = users
                        self.tableViewDelivery.reloadData()
                    }
                    else{
                        //Insérer une erreur si vide après
                    }
                    
                    
                }
       
        }
        
        

      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        
        let cell = tableViewDelivery.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = userList[indexPath.row].name
        cell.layer.shadowColor = UIColor(red: 58.0/255, green: 73.0/255, blue: 89.0/255, alpha: 1).cgColor
        //cell.layer.shadowOffset = CGSize(width: 2.0, height: 10)
        //cell.layer.shadowOpacity = 4.0
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userId = self.userList[indexPath.row].id
        DeliveryWebServices.getDeliveryUnique(id: userId!){err, success, user in
            guard err == nil else {
                return
            }
            guard (success != nil) else {
                return
            }
            DispatchQueue.main.async {
                let nextController = ItemDeliveryListViewController.newInstance(user: user!)
                self.navigationController?.pushViewController(nextController, animated: true)
            }
            }
            
        
    }

    @IBAction func goToCreateDeliveryMan(_ sender: Any) {
        let cdmViewController = CreateDeliveryManViewController()
        self.navigationController?.pushViewController(cdmViewController, animated: true)
    }
    
    @IBAction func goToBack(_ sender: Any) {
        let nextController = HomeViewController()
        self.navigationController?.pushViewController(nextController, animated: true)
    }

}
