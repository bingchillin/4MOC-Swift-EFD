//
//  PackageWebServices.swift
//  EFD
//
//  Created by Gabriel on 2/8/24.
//

import Foundation

class PackageWebServices {
    
    class func getAllPackages(completion: @escaping (Error?, [Package]?) -> Void) {
        let url = "http://localhost:3000/package"
        
        guard let getPackagesURL = URL(string: url) else {
            completion(NSError(domain: "com.YourApp", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "URL invalide"
            ]), nil)
            return
        }
        
        var request = URLRequest(url: getPackagesURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(error, nil)
                return
            }
            
            do {
                if let packageList = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    let packages = packageList.map { dict in
                        return Package(id: dict["_id"] as? String ?? "",
                                       name: dict["name"] as? String ?? "",
                                       status: dict["status"] as? String ?? "",
                                       proof: dict["proof"] as? String ?? "",
                                       latitude: dict["latitude"] as? Double,
                                       longitude: dict["longitude"] as? Double,
                                       idUserDelivery: dict["idUserDelivery"] as? String ?? "",
                                       isAffected: dict["isAffected"] as? Bool ?? false,
                                       idUserClient: dict["idUserClient"] as? String ?? "")
                    }
                    completion(nil, packages)
                } else {
                    completion(NSError(domain: "com.YourApp", code: 2, userInfo: [
                        NSLocalizedDescriptionKey: "Réponse invalide"
                    ]), nil)
                }
            } catch let error {
                completion(error, nil)
            }
        }
        task.resume()
    }
    
    class func getPackagesByLivreur(id: String, completion: @escaping (Error?, Bool?, [Package]?) -> Void){
        
        
        let url = "http://localhost:3000/package/delivery/" + id
        guard let itemURL = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: itemURL)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, false, nil)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.EFD", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), false, nil)
                return
            }
            
            do {
                if let itemList = try JSONSerialization.jsonObject(with: d, options: []) as? [[String: Any]] {
                    let packages = itemList.compactMap { dict in
                                        return Package(id: dict["_id"] as? String ?? "",
                                                       name: dict["name"] as? String ?? "",
                                                       status: dict["status"] as? String ?? "",
                                                       proof: dict["proof"] as? String ?? "",
                                                       latitude: dict["latitude"] as? Double,
                                                       longitude: dict["longitude"] as? Double,
                                                       idUserDelivery: dict["idUserDelivery"] as? String ?? "",
                                                       isAffected: dict["isAffected"] as? Bool ?? false,
                                                       idUserClient: dict["idUserClient"] as? String ?? "")
                                    }
                                    completion(nil, true, packages)
        
                }
                
            } catch let err {
                completion(err, false, nil)
                return
            }
        }
        task.resume()
    }
    
    class func getListDeliveryPackageProcess(id: String,completion: @escaping (Error?, Bool?, [Package]?) -> Void){
        
        
        let url = "http://localhost:3000/package/delivery/"+id + "/process"
        guard let itemURL = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: itemURL)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, false, nil)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.EFD", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), false, nil)
                return
            }
            
            do {
                if let itemList = try JSONSerialization.jsonObject(with: d, options: []) as? [[String: Any]] {
                    let packages = itemList.compactMap { dict in
                                        return Package(id: dict["_id"] as? String ?? "",
                                                       name: dict["name"] as? String ?? "",
                                                       status: dict["status"] as? String ?? "",
                                                       proof: dict["proof"] as? String ?? "",
                                                       latitude: dict["latitude"] as? Double,
                                                       longitude: dict["longitude"] as? Double,
                                                       idUserDelivery: dict["idUserDelivery"] as? String ?? "",
                                                       isAffected: dict["isAffected"] as? Bool ?? false,
                                                       idUserClient: dict["idUserClient"] as? String ?? "")
                                    }
                                    completion(nil, true, packages)
        
                }
                
            } catch let err {
                completion(err, false, nil)
                return
            }
        }
        task.resume()
    }
    
    class func getListPackageProcessCreate(completion: @escaping (Error?, Bool?, [Package]?) -> Void){
        
        
        let url = "http://localhost:3000/package/process/create"
        
        guard let itemURL = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: itemURL)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, false, nil)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.EFD", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), false, nil)
                return
            }
            
            do {
                if let itemList = try JSONSerialization.jsonObject(with: d, options: []) as? [[String: Any]] {
                    let packages = itemList.compactMap { dict in
                                        return Package(id: dict["_id"] as? String ?? "",
                                                       name: dict["name"] as? String ?? "",
                                                       status: dict["status"] as? String ?? "",
                                                       proof: dict["proof"] as? String ?? "",
                                                       latitude: dict["latitude"] as? Double,
                                                       longitude: dict["longitude"] as? Double,
                                                       idUserDelivery: dict["idUserDelivery"] as? String ?? "",
                                                       isAffected: dict["isAffected"] as? Bool ?? false,
                                                       idUserClient: dict["idUserClient"] as? String ?? "")
                                    }
                                    completion(nil, true, packages)
        
                }
                
            } catch let err {
                completion(err, false, nil)
                return
            }
        }
        task.resume()
    }
    
}
