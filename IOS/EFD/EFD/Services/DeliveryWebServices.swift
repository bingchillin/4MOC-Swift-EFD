//
//  DeliveryWebServices.swift
//  EFD
//
//  Created by Gabriel on 2/6/24.
//

import Foundation
class DeliveryWebServices {
    
    static let url = "http://localhost:3000/graphql"
    
    class func addDelivery(username: String, email: String, password: String, completion: @escaping (Error?, Bool?) -> Void) {
        
        
        guard let getAddURL = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: getAddURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Mutation GraphQL pour ajouter un livreur
        let mutation = """
        mutation {
            createUser(createUserInput: {
                name: "\(username)",
                email: "\(email)",
                password: "\(password)",
                role: "livreur"
            }) {
                id
                name
                email
                role
            }
        }
        """
        
        let json: [String: Any] = ["query": mutation]
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
                // Vérifiez si la réponse contient des données valides
                if let jsonResponse = try JSONSerialization.jsonObject(with: d, options: []) as? [String: Any],
                   let data = jsonResponse["data"] as? [String: Any],
                   let newUser = data["createUser"] as? [String: Any] {
                    
                    // Optionnel: Affichez les informations de l'utilisateur créé
                    print("User created: \(newUser["id"] ?? ""), \(newUser["name"] ?? ""), \(newUser["email"] ?? "")")
                    
                    // La création a réussi
                    completion(nil, true)
                } else {
                    completion(NSError(domain: "com.EFD", code: 4, userInfo: [
                        NSLocalizedFailureReasonErrorKey: "Failed to parse response"
                    ]), false)
                }
            } catch let err {
                completion(err, false)
            }
        }
        
        task.resume()
    }

    
    class func getListDelivery(completion: @escaping (Error?, [User]?) -> Void) {
        
        
        guard let deliveryURL = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: deliveryURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Créez la requête GraphQL pour obtenir la liste de tous les livreurs
        let query = """
        query {
            findAllLivreur {
                id
                name
                email
                password
                role
                latitude
                longitude
            }
        }
        """

        let json: [String: Any] = ["query": query]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        request.httpBody = jsonData
        request.httpMethod = "POST" // Utilisez POST pour les requêtes GraphQL

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
                // Vérifiez la réponse JSON pour récupérer les utilisateurs
                if let jsonResponse = try JSONSerialization.jsonObject(with: d, options: []) as? [String: Any],
                   let data = jsonResponse["data"] as? [String: Any],
                   let usersList = data["findAllLivreur"] as? [[String: Any]] {
                    
                    let users = usersList.compactMap { dict in
                        return User(id: dict["id"] as? String ?? "",
                                    name: dict["name"] as? String ?? "",
                                    email: dict["email"] as? String ?? "",
                                    password: dict["password"] as? String ?? "",
                                    role: dict["role"] as? String ?? "",
                                    latitude: dict["latitude"] as? Double,
                                    longitude: dict["longitude"] as? Double)
                    }
                    completion(nil, users)
                } else {
                    completion(NSError(domain: "com.EFD", code: 4, userInfo: [
                        NSLocalizedFailureReasonErrorKey: "Failed to parse user data"
                    ]), nil)
                }
            } catch let err {
                completion(err, nil)
                return
            }
        }
        task.resume()
    }

    
    class func getDeliveryUnique(id: String, completion: @escaping (Error?, Bool?, User?) -> Void) {
        
        
        guard let getUserURL = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: getUserURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let query = """
        query {
            user(id: "\(id)") {
                id
                name
                email
                password
                role
                latitude
                longitude
            }
        }
        """
        
        let json: [String: Any] = ["query": query]
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
  
                if let jsonResponse = try JSONSerialization.jsonObject(with: d, options: []) as? [String: Any],
                   let data = jsonResponse["data"] as? [String: Any],
                   let userData = data["user"] as? [String: Any] {
                    
                    // Créez un objet User à partir des données récupérées
                    let user = User(
                        id: userData["id"] as? String ?? "",
                        name: userData["name"] as? String ?? "",
                        email: userData["email"] as? String ?? "",
                        password: userData["password"] as? String ?? "",
                        role: userData["role"] as? String ?? "",
                        latitude: userData["latitude"] as? Double,
                        longitude: userData["longitude"] as? Double
                    )
                    completion(nil, true, user)
                } else {
                    completion(NSError(domain: "com.EFD", code: 4, userInfo: [
                        NSLocalizedFailureReasonErrorKey: "Failed to parse response"
                    ]), false, nil)
                }
            } catch let err {
                completion(err, false, nil)
            }
        }
        
        task.resume()
    }
    
    class func modifyDelivery(user: User, completion: @escaping (Error?, Bool?) -> Void) {
        
        
        guard let modifyURL = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: modifyURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Mutation GraphQL pour mettre à jour un utilisateur
        let mutation = """
        mutation {
            updateUser(id: "\(user.id!)", updateUserInput: {
                name: "\(user.name)",
                email: "\(user.email)",
                password: "\(user.password)",
                role: "\(user.role)"
            }) {
                id
                name
                email
                role
            }
        }
        """
        
        let json: [String: Any] = ["query": mutation]
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
                ]), false)
                return
            }
            
            do {
                // Vérifiez si JSON contient des données valides
                if let jsonResponse = try JSONSerialization.jsonObject(with: d, options: []) as? [String: Any],
                   let data = jsonResponse["data"] as? [String: Any],
                   let updatedUser = data["updateUser"] as? [String: Any] {
                    
                    // Affiche des infos de l'utilisateur mis à jour
                    print("User updated: \(updatedUser["id"] ?? ""), \(updatedUser["name"] ?? ""), \(updatedUser["email"] ?? ""), \(updatedUser["role"] ?? "")")
                    
                    // Modifs réussie
                    completion(nil, true)
                } else {
                    completion(NSError(domain: "com.EFD", code: 4, userInfo: [
                        NSLocalizedFailureReasonErrorKey: "Failed to parse response"
                    ]), false)
                }
            } catch let err {
                completion(err, false)
            }
        }
        
        task.resume()
    }

    
    class func DeleteUser(id: String, completion: @escaping (Error?, Bool?) -> Void) {

        guard let deleteURL = URL(string: url) else {
            return
        }
        

        var request = URLRequest(url: deleteURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let mutation = """
        mutation {
            remove(id: "\(id)")
        }
        """
        
        let json: [String: Any] = ["query": mutation]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        request.httpBody = jsonData
        request.httpMethod = "POST" // Utilisez POST

        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                print("Error: \(String(describing: err))")
                completion(err, false)
                return
            }
            
            guard let d = data else {
                completion(NSError(domain: "com.EFD", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), false)
                return
            }
            
            // Débogage de la réponse
            print("Response Data: \(String(data: d, encoding: .utf8) ?? "No response data")")
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: d, options: []) as? [String: Any],
                   let data = jsonResponse["data"] as? [String: Any],
                   let removedUser = data["remove"] as? String { // Assurez-vous que le nom correspond
                
                    print("User removed: \(removedUser)")
                    completion(nil, true)
                } else {
                    completion(NSError(domain: "com.EFD", code: 4, userInfo: [
                        NSLocalizedFailureReasonErrorKey: "Failed to parse response"
                    ]), false)
                }
            } catch let err {
                print("Error parsing response: \(err)")
                completion(err, false)
            }
        }
        
        task.resume()
    }


    
}
