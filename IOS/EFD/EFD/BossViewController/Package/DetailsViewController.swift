//
//  DetailsViewController.swift
//  EFD
//
//  Created by Gabriel on 2/14/24.
//

import UIKit

class DetailsViewController: UIViewController, UITextFieldDelegate {
    
    

    @IBOutlet weak var labelDetails: UILabel!
    
    @IBOutlet weak var textFieldSearch: UITextField!
    
    @IBOutlet weak var tableViewPackage: UITableView!
    
    var packageList = [Package]()
    
    var data =  [Package]()
    var filteredData: [Package] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldSearch.delegate = self
                
        // Configure la table view
        tableViewPackage.delegate = self
        tableViewPackage.dataSource = self
        tableViewPackage.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        callTableView()
        
        labelDetails.text = NSLocalizedString("Package details", comment: "")
        textFieldSearch.placeholder = NSLocalizedString("Search", comment: "")
    }
    
    func callTableView(){
         
        PackageWebServices.getAllPackages() { err, success, packages  in
                DispatchQueue.main.async {
                    if let packages = packages, !packages.isEmpty {
                        self.packageList = packages
                        
                        for i in 0..<self.packageList.count {
                            self.data.append(self.packageList[i])
                            print(self.data[i])
                            
                        }
                        self.tableViewPackage.reloadData()
                    }
                }
       
        }
    }
    
        func filterContentForSearchText(_ searchText: String) {
            filteredData = data.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            tableViewPackage.reloadData()
        }
        
        // UITextFieldDelegate method
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let currentText = textField.text else { return true }
            
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            filterContentForSearchText(newText)
            
            return true
        }


  

}

extension DetailsViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var arrayData: [Package] = []
        
        if filteredData.count != 0 {
            arrayData = filteredData
        }else{
            arrayData = packageList
        }
        
        let packageSelected = arrayData[indexPath.row]
            
        let nextController = ItemDetailsViewController.newInstance(package: packageSelected)
        self.navigationController?.pushViewController(nextController, animated: true)
        
    }
    
    
}



extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredData.isEmpty {
                return filteredData.count
            } else {
                return packageList.count
            }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var arrayData: [Package] = []
        
        let cell = tableViewPackage.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        if filteredData.count != 0 {
            arrayData = filteredData
        }else{
            arrayData = packageList
        }
        
        //cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cell.textLabel?.textColor = .black
       
        cell.textLabel?.text = arrayData[indexPath.row].name
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        cell.layer.shadowColor = UIColor(red: 58.0/255, green: 73.0/255, blue: 89.0/255, alpha: 1).cgColor
        //cell.layer.shadowOffset = CGSize(width: 2.0, height: 10)
        //cell.layer.shadowOpacity = 4.0
        
        return cell
        
        
    }
}
