//
//  EFDWebServices.swift
//  EFD
//
//  Created by Gabriel on 1/28/24.
//

import Foundation
import UIKit
import CryptoKit

class ConnexionWebServices{
    static var userId: String?
    static var userRole: String?
    static var username: String?
    
    class func addUser(username : String, email: String, password : String, completion: @escaping (Error?, Bool?, User?) -> Void){
        
    
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
                                   "role": "client"]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        request.httpMethod = "POST"
        
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
                try JSONSerialization.jsonObject(with: d, options: .allowFragments)
                let user = User(id: nil, name: username, email: email, password: password, role: "client", latitude: nil, longitude: nil)
                completion(nil, true, user)
            } catch let err {
                completion(err, false, nil)
                return
            }

        }
        
        task.resume()
    }
    
    class func connectUser(email : String, password : String, completion: @escaping (Error?, Bool?, User?) -> Void){
        
        
        let url = "http://localhost:3000/user/login"
        
        guard let getConnectUrl = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: getConnectUrl)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let json: [String: Any] = ["email": email,
                                   "password": password]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        
        request.httpBody = jsonData
        request.httpMethod = "POST"
        
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(err, false, nil)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.EFD", code: 3, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), nil, nil)
                return
            }
            
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [String: Any] {
                    if let id = jsonObject["_id"] as? String, let role = jsonObject["role"] as? String,  let name = jsonObject["name"] as? String{
                                        self.userId = id
                                        self.userRole = role
                                        self.username = name
                                    }
                                }
                if let userId = userId, let username = username, let userRole = userRole {
                    let user = User(id: userId, name: username, email: email, password: password, role: userRole, latitude: nil, longitude: nil)
                        completion(nil, true, user)
                    } else {
                        completion(NSError(domain: "com.EFD", code: 4, userInfo: [
                            NSLocalizedFailureReasonErrorKey: "Failed to extract username and/or userRole from JSON"
                        ]), false, nil)
                    }
                
            } catch let err {
                print("ok4")
                print("Error during JSON serialization: \(err)")
                completion(err, false,nil)
                return
            }

        }
        task.resume()
        
    }
    
    
    

}
