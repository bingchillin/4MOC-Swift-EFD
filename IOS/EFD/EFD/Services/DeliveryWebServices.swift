//
//  DeliveryWebServices.swift
//  EFD
//
//  Created by Gabriel on 2/6/24.
//

import Foundation
class DeliveryWebServices {
    
    class func addDelivery(username : String, email: String, password : String, completion: @escaping (Error?, Bool?) -> Void){
        
    
        let url = "http://localhost:3000/user"
        
        guard let getAddURL = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: getAddURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //let inputData = password.data(using: .utf8)
        
        // Calculer le hachage SHA-256
        //let hashedData = SHA256.hash(data: inputData!)
            
        // Convertir le hachage en une chaîne hexadécimale
        //let passwordDataHash = hashedData.map { String(format: "%02hhx", $0) }.joined()
        
        

        let json: [String: Any] = ["name": username,
                                   "email": email,
                                   "password": password,
                                   "role": "livreur"]

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
    
    class func getListDelivery(completion: @escaping (Error?, [User]?) -> Void){
        
        let url = "http://localhost:3000/user/livreur"
        
        guard let getDeliveryURL = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: getDeliveryURL)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            
            guard err == nil else {
                completion(err, nil)
                return
            }
            
            guard let d = data else {
                completion(NSError(domain: "com.EFD", code: 3, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), nil)
                return
            }
            
            do {
                if let itemList = try JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [[String: Any]] {
                    let users = itemList.compactMap { dict in
                                        return User(id: dict["_id"] as? String ?? "",
                                                    name: dict["name"] as? String ?? "",
                                                    email: dict["email"] as? String ?? "",
                                                    password: dict["password"] as? String ?? "",
                                                    role: dict["role"] as? String ?? "",
                                                    latitude: dict["latitude"] as? Double,
                                                    longitude: dict["longitude"] as? Double )
                                    }
                                    completion(nil, users)
                }
                
            } catch let err {
                completion(err, nil)
                return
            }
        }
        task.resume()
    }
    
    class func getDeliveryUnique(id: String,completion: @escaping (Error?, Bool?, User?) -> Void){
        
        
        let url = "http://localhost:3000/user/"+id
        
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
                if let item = try JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [String: Any] {
                    let user = User(id: item["_id"] as? String ?? "",
                                    name: item["name"] as? String ?? "",
                                    email: item["email"] as? String ?? "",
                                    password: item["password"] as? String ?? "",
                                    role: item["role"] as? String ?? "",
                                    latitude: item["latitude"] as? Double,
                                    longitude: item["longitude"] as? Double)
                    completion(nil, true, user)
                }
                
            } catch let err {
                completion(err, false, nil)
                return
            }
        }
        task.resume()
    }
    
    class func modifyDelivery(user: User, completion: @escaping (Error?, Bool?) -> Void){
        
    
        let url = "http://localhost:3000/user/" + user.id!
        
        guard let getAddURL = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: getAddURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        

        let json: [String: Any] = ["name": user.name,
                                   "email": user.email,
                                   "password": user.password,
                                   "role": user.role]

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
    class func DeleteUser(id: String,completion: @escaping (Error?, Bool?) -> Void){
        
        
        let url = "http://localhost:3000/user/"+id
        
        guard let itemURL = URL(string: url) else{
            return
        }
        var request = URLRequest(url: itemURL)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, false)
                return
            }
            guard data != nil else {
                completion(NSError(domain: "com.EFD", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), false)
                return
            }
               
                completion(nil, true)
                
        }
        
        task.resume()
    }
    
}
