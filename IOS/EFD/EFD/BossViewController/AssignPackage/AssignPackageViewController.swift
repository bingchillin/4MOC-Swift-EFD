//
//  AssignPackageViewController.swift
//  EFD
//
//  Created by Gabriel on 2/14/24.
//

import UIKit

class AssignPackageViewController: UIViewController {

    @IBOutlet weak var labelEmptyUser: UILabel!
    @IBOutlet weak var tableViewDelivery: UITableView!
    
    var userList = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(listAssign)
        
        tableViewDelivery.delegate = self
        tableViewDelivery.dataSource = self
        tableViewDelivery.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        
        DeliveryWebServices.getListDelivery() { err, users in
                DispatchQueue.main.async {
                    if let users = users {
                        self.labelEmptyUser.textColor = UIColor.white
                        self.labelEmptyUser.isHidden = true
                        self.userList = users
                        self.tableViewDelivery.reloadData()
                    }
                    else{
                        self.labelEmptyUser.textColor = UIColor.black
                        self.labelEmptyUser.isHidden = false
                        self.tableViewDelivery.isHidden = true
                    }
                }
        }
    }

    var listAssign : [String]!
    
    public class func newInstance(listAssign: [String]) -> AssignPackageViewController{
        let apvc = AssignPackageViewController()
        apvc.listAssign = listAssign
        return apvc
    }

   

}


extension AssignPackageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userId = self.userList[indexPath.row].id
        
        let alertVerif = UIAlertController(title: "Demande de validation", message: "Etes vous sur de vouloir assigner ce livreur ?", preferredStyle: .alert)
        
        // Action "Oui"
        alertVerif.addAction(UIAlertAction(title: "Oui", style: .default, handler: { _ in
           
            for i in 0..<self.listAssign.count{
                print(self.listAssign[i])
                
                PackageWebServices.modifyPackage(idP: self.listAssign[i], idUD: userId!){err, success in
                    guard err == nil else {
                        return
                    }
                    guard (success != nil) else {
                        return
                    }
                }
                
            }
            
            let alertValidation = UIAlertController(title: "Assignation effectuée", message: "L'assignation a bien été réalisée", preferredStyle: .alert)
            alertValidation.addAction(UIAlertAction(title: "Fermer", style: .cancel, handler: { _ in
                let hmViewController = HomeViewController()
                self.navigationController?.pushViewController(hmViewController, animated: true)
            }))

           
            self.present(alertValidation, animated: true)
            
            
            
        }))
        
        // Action "Non"
        alertVerif.addAction(UIAlertAction(title: "Non", style: .cancel))
        self.present(alertVerif, animated: true)

        
        
        

    }
}

extension AssignPackageViewController: UITableViewDataSource {
    
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
}

