//
//  EFDWebServices.swift
//  EFD
//
//  Created by Gabriel on 1/28/24.
//

import Foundation
import UIKit
import CryptoKit

class EFDWebServices{
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
                ]), nil, nil)
                return
            }
            
            do {
                try JSONSerialization.jsonObject(with: d, options: .allowFragments)
                let user = User(name: username, email: email, password: password, role: "client")
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
                    if let role = jsonObject["role"] as? String,  let username = jsonObject["name"] as? String{
                                        self.userRole = role
                                        self.username = username
                                    }
                                }
                let user = User(name: username!, email: email, password: password, role: userRole!)
                completion(nil, true, user)
            } catch let err {
                print("Error during JSON serialization: \(err)")
                completion(err, false,nil)
                return
            }

        }
        task.resume()
        
    }
    
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
                                   "role": "delivery"]

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
    

}
