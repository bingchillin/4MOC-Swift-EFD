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
    
    static let baseURL = "http://localhost:3000/graphql" // URL du point d'entrée GraphQL

       class func addUser(username: String, email: String, password: String, completion: @escaping (Error?, Bool?, User?) -> Void) {

     
           let url = URL(string: baseURL)!
           var request = URLRequest(url: url)
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.httpMethod = "POST"

           // Composer la requête GraphQL
           let query = """
           mutation {
             createUser(createUserInput: {name: "\(username)", email: "\(email)", password: "\(password)", role: "client"}) {
               id
               name
               email
               role
             }
           }
           """

           let json: [String: Any] = ["query": query]
           let jsonData = try? JSONSerialization.data(withJSONObject: json)

           request.httpBody = jsonData

           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               guard error == nil else {
                   completion(error, false, nil)
                   return
               }
               guard let data = data else {
                   completion(NSError(domain: "com.EFD", code: 2, userInfo: [
                       NSLocalizedFailureReasonErrorKey: "No data found"
                   ]), false, nil)
                   return
               }

               do {
                   
                   print("okkkk")
                   // Décoder la réponse
                   if let responseDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                      let data = responseDict["data"] as? [String: Any],
                      let createdUser = data["createUser"] as? [String: Any] {
                       
                       let user = User(id: createdUser["id"] as? String,
                                       name: (createdUser["name"] as? String)!,
                                       email: (createdUser["email"] as? String)!,
                                       password: password,
                                       role: (createdUser["role"] as? String)!,
                                       latitude: nil,
                                       longitude: nil)
                       completion(nil, true, user)
                   } else {
                       print("okkefdkk")
                       print(String(data: data, encoding: .utf8) ?? "No readable data")
                       completion(NSError(domain: "com.EFD", code: 3, userInfo: [
                           NSLocalizedFailureReasonErrorKey: "Unexpected response format"
                       ]), false, nil)
                   }
               } catch let err {
                   print("okkfezedkk")
                   completion(err, false, nil)
                   return
               }
           }
           
           task.resume()
       }
    
    class func connectUser(email: String, password: String, completion: @escaping (Error?, Bool?, User?) -> Void) {
            
            guard let connectUrl = URL(string: baseURL) else {
                return
            }
            
            var request = URLRequest(url: connectUrl)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            // Composer la requête GraphQL pour la connexion
            let query = """
            mutation {
              login(email: "\(email)", password: "\(password)") {
                id
                name
                email
                role
              }
            }
            """
            
            let json: [String: Any] = ["query": query]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    completion(error, false, nil)
                    return
                }
                guard let d = data else {
                    completion(NSError(domain: "com.EFD", code: 3, userInfo: [
                        NSLocalizedFailureReasonErrorKey: "No data found"
                    ]), false, nil)
                    return
                }
                
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [String: Any],
                       let data = jsonObject["data"] as? [String: Any],
                       let userJson = data["login"] as? [String: Any] {
                        
                        // Extraire les valeurs utilisateur à partir de la réponse GraphQL
                        if let userId = userJson["id"] as? String,
                           let username = userJson["name"] as? String,
                           let userEmail = userJson["email"] as? String,
                           let userRole = userJson["role"] as? String {
                            
                            // Créer un utilisateur et retourner via le callback
                            let user = User(id: userId, name: username, email: userEmail, password: password, role: userRole, latitude: nil, longitude: nil)
                            completion(nil, true, user)
                        } else {
                            completion(NSError(domain: "com.EFD", code: 4, userInfo: [
                                NSLocalizedFailureReasonErrorKey: "Failed to extract user data from JSON"
                            ]), false, nil)
                        }
                    } else {
                        completion(NSError(domain: "com.EFD", code: 5, userInfo: [
                            NSLocalizedFailureReasonErrorKey: "Unexpected response format"
                        ]), false, nil)
                    }
                } catch let err {
                    completion(err, false, nil)
                }
            }
            task.resume()
        }
    
    
    

}
