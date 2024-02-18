//
//  HomeViewController.swift
//  EFD
//
//  Created by Gabriel on 1/28/24.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    var locationManager: CLLocationManager?

    @IBOutlet weak var buttonDeliveryMan: UIButton!
    @IBOutlet weak var buttonDetail: UIButton!
    @IBOutlet weak var buttonAssign: UIButton!
    @IBOutlet weak var buttonValidate: UIButton!
    @IBOutlet weak var labelRound: UILabel!
    
    @IBOutlet weak var tableViewPackages: UITableView!
    @IBOutlet weak var labelEmptyPackage: UILabel!
    
    @IBOutlet weak var buttonMap: UIButton!
    
    @IBAction func goToMap(_ sender: Any) {
        if self.locationManager == nil {
            // premier clic sur le bouton gps
            let manager = CLLocationManager()
            manager.delegate = self
            
            if CLLocationManager.authorizationStatus() == .notDetermined {
                manager.requestWhenInUseAuthorization()
            }
            
            self.locationManager = manager // obligatoire de mémoriser la variable sinon cancel la geoloc
        } else {
            self.handleLocationManagerStatus(self.locationManager!)
        }
        
        let mapViewController = MapViewController()
        navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    var user : User!
    
    var packageList = [Package]()
    var listAssign = [String]()
    
    var selectedIndexPaths = [IndexPath]()
    
    fileprivate func getAllPackages() {
        PackageWebServices.getListPackageProcessCreate() { err, success, packages  in
            DispatchQueue.main.async {
                if let packages = packages, !packages.isEmpty {
                    self.labelEmptyPackage.textColor = UIColor.white
                    self.labelEmptyPackage.isHidden = true
                    self.packageList = packages
                    self.tableViewPackages.reloadData()
                }
                else {
                    //Si liste retour vide ou erreur
                    self.labelEmptyPackage.textColor = UIColor.black
                    self.labelEmptyPackage.isHidden = false
                    self.tableViewPackages.isHidden = true
                }
            }
        }
    }
    
    func getPackagesByLivreur(id: String) {
        PackageWebServices.getPackagesByLivreur(id: id) { error, success, packages in
            DispatchQueue.main.async {
                if let packages = packages, !packages.isEmpty {
                    self.labelEmptyPackage.textColor = UIColor.white
                    self.labelEmptyPackage.isHidden = true
                    self.packageList = packages
                    self.tableViewPackages.reloadData()
                }
                else {
                    //Si liste retour vide ou erreur
                    self.labelEmptyPackage.textColor = UIColor.black
                    self.labelEmptyPackage.isHidden = false
                    self.labelEmptyPackage.text = "Vous n'avez pas de tournée en cours"
                    self.tableViewPackages.isHidden = true
                }
            }
        }
    }
    
    func getPackagesByLivreurLoading(id: String) {
        PackageWebServices.getListDeliveryPackageProcess(id: id) { error, success, packages in
            DispatchQueue.main.async {
                if let packages = packages, !packages.isEmpty {
                    self.labelEmptyPackage.textColor = UIColor.white
                    self.labelEmptyPackage.isHidden = true
                    self.packageList = packages
                    self.tableViewPackages.reloadData()
                }
                else {
                    //Si liste retour vide ou erreur
                    self.labelEmptyPackage.textColor = UIColor.black
                    self.labelEmptyPackage.isHidden = false
                    self.labelEmptyPackage.text = "Vous n'avez pas de tournée en cours"
                    self.tableViewPackages.isHidden = true
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide back button
        self.navigationItem.hidesBackButton = true
        
        buttonDeliveryMan.setTitle(NSLocalizedString("DeliveryMan", comment: ""), for: .normal)
        labelRound.text = NSLocalizedString("Round", comment: "")
        buttonDetail.setTitle(NSLocalizedString("Detail", comment: ""), for: .normal)
        buttonMap.setTitle(NSLocalizedString("Map", comment: ""), for: .normal)
        buttonAssign.setTitle(NSLocalizedString("Assign", comment: ""), for: .normal)
        buttonValidate.setTitle(NSLocalizedString("Validate", comment: ""), for: .normal)
        
        // Récupérer une valeur à partir du cache en utilisant singleton
        let cache = UserInMemoryService.shared

        user = cache.userValue()
        let userRole = user.role
        
        //print(user.id!, user.email, user.name, user.role, "OK")
        
        buttonDeliveryMan.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        buttonDetail.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        buttonAssign.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        
        tableViewPackages.dataSource = self
        tableViewPackages.delegate = self
        tableViewPackages.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.tableViewPackages.allowsMultipleSelection = true
        self.tableViewPackages.allowsMultipleSelectionDuringEditing = true
 
        displayViewByRole(role: userRole)
    }
    
    @IBAction func goToDetails(_ sender: Any) {
        let nextViewController = DetailsViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    @IBAction func goToAssign(_ sender: Any) {
        listAssign.removeAll()
        
        for i in 0..<selectedIndexPaths.count {
                listAssign.append(packageList[selectedIndexPaths[i][1]].id)
            
        }
    
        let nextController = AssignPackageViewController.newInstance(listAssign: self.listAssign)
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    @IBAction func goToDeliveryMan(_ sender: Any) {
        let dmViewController = DeliveryViewController()
        self.navigationController?.pushViewController(dmViewController, animated: true)
    }
    
    
    
    
    public func displayViewByRole(role: String) -> Void {
        if role == "admin" {
            buttonDeliveryMan.isHidden = false
            buttonAssign.isHidden = true
            buttonMap.isHidden = true
            labelRound.isHidden = false
            buttonDetail.isHidden = false
            tableViewPackages.isHidden = false
            
            getAllPackages()
        } else if role == "livreur" {
            tableViewPackages.isHidden = false
            buttonMap.isHidden = false
            buttonValidate.isHidden = false
            
            getPackagesByLivreurLoading(id: user.id!)
        }
    }
}





extension HomeViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Mettre à jour l'apparence de la cellule
            tableViewPackages.reloadRows(at: [indexPath], with: .automatic)
            
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
            buttonAssign.isHidden = false
        }else {
            buttonAssign.isHidden = true
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.packageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewPackages.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
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
