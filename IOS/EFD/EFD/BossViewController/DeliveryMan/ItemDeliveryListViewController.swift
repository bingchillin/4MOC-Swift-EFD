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
    @IBOutlet weak var buttonDeassign: UIButton!
    @IBOutlet weak var labelEmptyPackage: UILabel!
    
    @IBOutlet weak var tableViewPackage: UITableView!
    
    var packageList = [Package]()
    var selectedIndexPaths = [IndexPath]()
    var listDeassign = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide back button
        self.navigationItem.hidesBackButton = true
        
        labelName.text = user.name
        
        buttonModify.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        buttonDelete.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        buttonDeassign.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        
        tableViewPackage.delegate = self
        tableViewPackage.dataSource = self
        tableViewPackage.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableViewPackage.estimatedRowHeight = 80 // Par exemple, 80 points de hauteur estimée
         
        
         
        callTableView()
        
        
        
    }
    
    func callTableView(){
         
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
    
    @IBAction func goToDeassign(_ sender: Any) {
        
        listDeassign.removeAll()
        
        for i in 0..<selectedIndexPaths.count {
            listDeassign.append(packageList[selectedIndexPaths[i][1]].id)
            
        }
        
        let alertVerif = UIAlertController(title: "Demande de validation", message: "Etes vous sur de vouloir deassigner ce coli ?", preferredStyle: .alert)
        
        // Action "Oui"
        alertVerif.addAction(UIAlertAction(title: "Oui", style: .default, handler: { _ in
           
            for i in 0..<self.listDeassign.count{
                
                PackageWebServices.modifyPackage(idP: self.listDeassign[i], idUD: "", status: "create"){err, success in
                    guard err == nil else {
                        return
                    }
                    guard (success != nil) else {
                        return
                    }
                    
                }
            }
            
            let alertValidation = UIAlertController(title: "Déassignation effectuée", message: "La déassignation a bien été réalisée", preferredStyle: .alert)
            alertValidation.addAction(UIAlertAction(title: "Fermer", style: .cancel))
            self.present(alertValidation, animated: true)
            
            self.callTableView()
    
            self.resetCellProperties()
            
            self.selectedIndexPaths.removeAll()
            self.buttonDeassign.isHidden = true
            
            
            
            
        }))
        
        // Action "Non"
        alertVerif.addAction(UIAlertAction(title: "Non", style: .cancel))
        self.present(alertVerif, animated: true)
        
        
        

    }
    
    func resetCellProperties() {
        
        guard let visibleIndexPaths = tableViewPackage.indexPathsForVisibleRows else {
            return
        }
        
        for indexPath in visibleIndexPaths {
            if let cell = tableViewPackage.cellForRow(at: indexPath) {
                // Réinitialise les propriétés visuelles de la cellule
                cell.contentView.backgroundColor = UIColor.white
                cell.layer.shadowColor = UIColor.clear.cgColor
                
            }
        }
    }

    
    

}
    

extension ItemDeliveryListViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let packageId = self.packageList[indexPath.row].id
        print(packageId, self.packageList[indexPath.row].name)
            
        // Mettre à jour l'apparence de la cellule
        tableViewPackage.reloadRows(at: [indexPath], with: .automatic)
            
        let cell = tableView.cellForRow(at: indexPath)
            
        // Mettre à jour le tableau des indexPaths sélectionnées
        if let index = selectedIndexPaths.firstIndex(of: indexPath) {
                selectedIndexPaths.remove(at: index)
                cell?.backgroundColor = UIColor.white // Rétablir la couleur de fond d'origine
                cell?.layer.shadowColor = UIColor.clear.cgColor // Supprimer l'ombre
                        
        } else {
                selectedIndexPaths.append(indexPath)
                cell?.backgroundColor = UIColor(red: 0.0, green: 1, blue: 0.0, alpha: 1.0) // Changement de couleur de fond
                cell?.layer.shadowColor = UIColor.blue.cgColor // Ajout d'une ombre
            }
        if !selectedIndexPaths.isEmpty{
            buttonDeassign.isHidden = false
        }else {
            buttonDeassign.isHidden = true
        }
    }
    
    
}

extension ItemDeliveryListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.packageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        
        let cell = tableViewPackage.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        //cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cell.textLabel?.textColor = .black
       
        cell.textLabel?.text = packageList[indexPath.row].name
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        cell.layer.shadowColor = UIColor(red: 58.0/255, green: 73.0/255, blue: 89.0/255, alpha: 1).cgColor
        //cell.layer.shadowOffset = CGSize(width: 2.0, height: 10)
        //cell.layer.shadowOpacity = 4.0
        
        return cell
    }
}

