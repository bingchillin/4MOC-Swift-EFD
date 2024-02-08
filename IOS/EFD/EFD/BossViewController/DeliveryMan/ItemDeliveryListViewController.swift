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
    
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var labelEmptyPackage: UILabel!
    
    @IBOutlet weak var tableViewPackage: UITableView!
    
    var packageList = [Package]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide back button
        self.navigationItem.hidesBackButton = true
        
        labelName.text = user.name
        
        buttonModify.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        buttonDelete.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        
        tableViewPackage.delegate = self
        tableViewPackage.dataSource = self
        tableViewPackage.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableViewPackage.estimatedRowHeight = 80 // Par exemple, 80 points de hauteur estimée
            
        
        PackageWebServices.getListDeliveryPackageProcess(id: user.id!) { err, success, packages  in
                DispatchQueue.main.async {
                    if let packages = packages, !packages.isEmpty {
                        self.labelEmptyPackage.textColor = UIColor.white
                        self.labelEmptyPackage.isHidden = true
                        self.packageList = packages
                        self.tableViewPackage.reloadData()
                    }
                    else{
                        self.labelEmptyPackage.textColor = UIColor.black
                        self.labelEmptyPackage.isHidden = false
                        self.tableViewPackage.isHidden = true
                    }
                    
                    
                }
       
        }
        
        
    }
    
    var user : User!
    
    
    public class func newInstance(user: User) -> ItemDeliveryListViewController{
            let itemVDelivery = ItemDeliveryListViewController()
            itemVDelivery.user = user
            return itemVDelivery
    }
    
    @IBAction func goToBack(_ sender: Any) {
        let nextController = DeliveryViewController()
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    
    @IBAction func goToModify(_ sender: Any) {
        let nextController = ModifyItemDeliveryListViewController.newInstance(user: user!)
        self.navigationController?.pushViewController(nextController, animated: true)
        
    }
    
  
    @IBAction func goDeleteDelivery(_ sender: Any) {
        
        if self.packageList.isEmpty {
            
            let alertVerif = UIAlertController(title: "Demande de validation", message: "Etes vous sur de vouloir supprimer ce livreur ?", preferredStyle: .alert)
            
            // Action "Oui"
            alertVerif.addAction(UIAlertAction(title: "Oui", style: .default, handler: { _ in
               
                DeliveryWebServices.DeleteUser(id: self.user.id!){ err, success in
                        guard (success != nil) else {
                            return
                        }
                        DispatchQueue.main.async {
                            if success == true {
                                let alert = UIAlertController(title: "Suppression validée", message: "La suppression a bien été effectuée", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Fermer", style: .cancel, handler: { _ in
                                    let dmViewController = DeliveryViewController()
                                    self.navigationController?.pushViewController(dmViewController, animated: true)
                                }))
                                self.present(alert, animated: true)
                                

                            }else{
                                let alertError = UIAlertController(title: "Suppression impossible", message: "Error: suppression impossible", preferredStyle: .alert)
                                alertError.addAction(UIAlertAction(title: "Fermer", style: .cancel))
                                self.present(alertError, animated: true)
                            }
                            
                        }
                }
            }))

            // Action "Non"
            alertVerif.addAction(UIAlertAction(title: "Non", style: .cancel))
            self.present(alertVerif, animated: true)
            
        }else{
            let alert = UIAlertController(title: "Suppression impossible", message: "La suppression n'est possible que si le livreur n'a aucun colis en cours", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Fermer", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    

   

}

extension ItemDeliveryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let packageId = self.packageList[indexPath.row].id
        print(packageId, self.packageList[indexPath.row].name)
        
            
        
    }
}

extension ItemDeliveryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.packageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        
        let cell = tableViewPackage.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cell.textLabel?.textColor = .black
       
        // Créez deux labels pour afficher deux textes
        let nameLabel = UILabel(frame: CGRect(x: 15, y: 10, width: 200, height: 20))
        nameLabel.text = "title: " + packageList[indexPath.row].name
        cell.contentView.addSubview(nameLabel)
            
        let statusLabel = UILabel(frame: CGRect(x: 15, y: 30, width: 200, height: 20))
        statusLabel.text = "status: " + packageList[indexPath.row].status
        cell.contentView.addSubview(statusLabel)
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
            
        
        cell.layer.shadowColor = UIColor(red: 58.0/255, green: 73.0/255, blue: 89.0/255, alpha: 1).cgColor
        //cell.layer.shadowOffset = CGSize(width: 2.0, height: 10)
        //cell.layer.shadowOpacity = 4.0
        
       
        return cell
    }
}

