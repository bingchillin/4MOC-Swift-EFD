//
//  PackageWebServices.swift
//  EFD
//
//  Created by Gabriel on 2/8/24.
//

import Foundation

class PackageWebServices {
    
    class func getAllPackages(completion: @escaping (Error?, Bool?, [Package]?) -> Void){
        
        
        let url = "http://localhost:3000/package"
        
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
        
        
        let url = "http://localhost:3000/package/delivery/" + id + "/process"
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
    
    class func modifyPackage(idP: String, idUD: String, status: String, completion: @escaping (Error?, Bool?) -> Void){
        
    
        let url = "http://localhost:3000/package/" + idP
        
        guard let getAddURL = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: getAddURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        

        let json: [String: Any] = ["idUserDelivery": idUD,
                                   "status": status]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        request.httpMethod = "PATCH"
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, false)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.EFD", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), false)
                return
            }
            
            do {
                try JSONSerialization.jsonObject(with: d, options: .allowFragments)
                completion(nil, true)
            } catch let err {
                completion(err, false)
                return
            }

        }
        
        task.resume()
    }
    
    class func modifySavePackage(idP: String, proof: String, completion: @escaping (Error?, Bool?) -> Void){
        
    
        let url = "http://localhost:3000/package/" + idP
        
        guard let getAddURL = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: getAddURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        

        let json: [String: Any] = ["proof": proof,
                                   "status": "success"]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        request.httpMethod = "PATCH"
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, false)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.EFD", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), false)
                return
            }
            
            do {
                try JSONSerialization.jsonObject(with: d, options: .allowFragments)
                completion(nil, true)
            } catch let err {
                completion(err, false)
                return
            }

        }
        
        task.resume()
    }
    
    class func addPackage(idUserClient : String, name : String, longitude: String, latitude : String, completion: @escaping (Error?, Bool?) -> Void){
        
    
        let url = "http://localhost:3000/package"
        
        guard let getAddURL = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: getAddURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        

        let json: [String: Any] = ["name": name,
                                   "status": "create",
                                   "proof": "",
                                   "latitude": latitude,
                                   "longitude": longitude,
                                   "idUserClient": idUserClient,
                                   "idUserDelivery": "",
                                   "isAffected": false]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, false)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.EFD", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), nil)
                return
            }
            
            do {
                try JSONSerialization.jsonObject(with: d, options: .allowFragments)
                completion(nil, true)
            } catch let err {
                completion(err, false)
                return
            }

        }
        
        task.resume()
    }
    
    class func getListClientPackageSuccess(id: String,completion: @escaping (Error?, Bool?, [Package]?) -> Void){
        
        
        let url = "http://localhost:3000/package/user/" + id + "/success"
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
    
    class func modifyStatusPackageC(idP: String, status: String, completion: @escaping (Error?, Bool?) -> Void){
        
    
        let url = "http://localhost:3000/package/" + idP
        
        guard let getAddURL = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: getAddURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        

        let json: [String: Any] = ["status": status]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        request.httpMethod = "PATCH"
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, false)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.EFD", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), false)
                return
            }
            
            do {
                try JSONSerialization.jsonObject(with: d, options: .allowFragments)
                completion(nil, true)
            } catch let err {
                completion(err, false)
                return
            }

        }
        
        task.resume()
    }
}
