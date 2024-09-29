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
    
    class func getListDeliveryPackageProcess(id: String, completion: @escaping (Error?, Bool?, [Package]?) -> Void) {
        
        
        let url = "http://localhost:3000/graphql"
        guard let itemURL = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: itemURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Créez la requête GraphQL
        let query = """
        query {
            findPackageByDeliveryProcess(id: "\(id)") {
                id
                name
                status
                proof
                latitude
                longitude
                idUserDelivery
                isAffected
                idUserClient
            }
        }
        """
        
        let json: [String: Any] = ["query": query]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        request.httpBody = jsonData
        request.httpMethod = "POST" // Utilisez POST pour les requêtes GraphQL
        
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
                // Décoder la réponse JSON pour récupérer la liste des paquets
                if let jsonResponse = try JSONSerialization.jsonObject(with: d, options: []) as? [String: Any],
                   let data = jsonResponse["data"] as? [String: Any],
                   let itemList = data["findPackageByDeliveryProcess"] as? [[String: Any]] {
                    
                    let packages = itemList.compactMap { dict in
                        return Package(id: dict["id"] as? String ?? "",
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

    
    class func getListPackageProcessCreate(completion: @escaping (Error?, Bool?, [Package]?) -> Void) {
        
        let url = "http://localhost:3000/graphql"
        
        guard let itemURL = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: itemURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Créez la requête GraphQL pour obtenir la liste des packages créés
        let query = """
        query {
            findPackageByProcess {
                id
                name
                status
                proof
                latitude
                longitude
                idUserDelivery
                isAffected
                idUserClient
            }
        }
        """

        let json: [String: Any] = ["query": query]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        request.httpBody = jsonData
        request.httpMethod = "POST" // Utilisez POST pour les requêtes GraphQL

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
                // Vérifiez la réponse JSON pour récupérer les packages
                if let jsonResponse = try JSONSerialization.jsonObject(with: d, options: []) as? [String: Any],
                   let data = jsonResponse["data"] as? [String: Any],
                   let packagesList = data["findPackageByProcess"] as? [[String: Any]] {
                    
                    let packages = packagesList.compactMap { dict in
                        return Package(id: dict["id"] as? String ?? "",
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
                } else {
                    completion(NSError(domain: "com.EFD", code: 4, userInfo: [
                        NSLocalizedFailureReasonErrorKey: "Failed to parse package data"
                    ]), nil, nil)
                }
            } catch let err {
                completion(err, nil, nil)
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
    
    class func modifySavePackage(idP: String, proof: String, completion: @escaping (Error?, Bool?) -> Void) {
        
        let url = "http://localhost:3000/graphql"
        guard let itemURL = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: itemURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Créez la mutation GraphQL
        let mutation = """
        mutation {
            updatePackage(id: "\(idP)", updatePackageInput: { proof: "\(proof)", status: "success" }) {
                id
                proof
                status
            }
        }
        """
        
        let json: [String: Any] = ["query": mutation]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        request.httpBody = jsonData
        request.httpMethod = "POST" // Utilisez POST pour les mutations GraphQL

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
                // Vérifiez la réponse JSON pour voir si la mutation a réussi
                if let jsonResponse = try JSONSerialization.jsonObject(with: d, options: []) as? [String: Any],
                   let data = jsonResponse["data"] as? [String: Any],
                   let updatedPackage = data["updatePackage"] as? [String: Any] {
                    completion(nil, true)
                } else {
                    completion(NSError(domain: "com.EFD", code: 3, userInfo: [
                        NSLocalizedFailureReasonErrorKey: "Mutation failed"
                    ]), false)
                }
            } catch let err {
                completion(err, false)
                return
            }
        }
        task.resume()
    }

    
    /*class func addPackage(idUserClient : String, name : String, longitude: String, latitude : String, completion: @escaping (Error?, Bool?) -> Void){
        
    
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
    }*/
    
    class func addPackage(idUserClient: String, name: String, longitude: String, latitude: String, completion: @escaping (Error?, Bool?) -> Void) {

        let url = "http://localhost:3000/graphql"  // URL de l'API GraphQL
        
        guard let getAddURL = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: getAddURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // GraphQL Mutation as a string
        let graphQLMutation = """
        mutation {
          createPackage(createPackageInput: {
            name: "\(name)",
            status: "create",
            proof: "",
            latitude: \(latitude),
            longitude: \(longitude),
            idUserClient: "\(idUserClient)",
            idUserDelivery: "",
            isAffected: false
          }) {
            id
            name
          }
        }
        """
        
        // Construct the GraphQL request body
        let json: [String: Any] = [
            "query": graphQLMutation
        ]
        
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
                // Parse the GraphQL response
                if let jsonResponse = try JSONSerialization.jsonObject(with: d, options: []) as? [String: Any],
                   let data = jsonResponse["data"] as? [String: Any],
                   let createPackageResponse = data["createPackage"] as? [String: Any] {
                    
                    // Check for a successful response, for example:
                    if let packageId = createPackageResponse["id"] as? String {
                        print("Package created with ID: \(packageId)")
                        completion(nil, true)
                    } else {
                        completion(NSError(domain: "com.EFD", code: 3, userInfo: [
                            NSLocalizedFailureReasonErrorKey: "Failed to create package"
                        ]), false)
                    }
                    
                } else {
                    completion(NSError(domain: "com.EFD", code: 4, userInfo: [
                        NSLocalizedFailureReasonErrorKey: "Invalid response format"
                    ]), false)
                }
                
            } catch let err {
                completion(err, false)
                return
            }

        }
        
        task.resume()
    }

    
    class func getListClientPackageSuccess(id: String, completion: @escaping (Error?, Bool?, [Package]?) -> Void) {

        let url = "http://localhost:3000/graphql"  // URL de l'API GraphQL

        guard let itemURL = URL(string: url) else {
            return
        }

        var request = URLRequest(url: itemURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // GraphQL Query
        let graphQLQuery = """
        query {
          findPackageByUserIdSuccess(idUserClient: "\(id)") {
            id
            name
            status
            proof
            latitude
            longitude
            idUserClient
            idUserDelivery
            isAffected
          }
        }
        """

        // Construire le corps de la requête GraphQL
        let json: [String: Any] = [
            "query": graphQLQuery
        ]

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
                // Analyse de la réponse GraphQL
                if let jsonResponse = try JSONSerialization.jsonObject(with: d, options: []) as? [String: Any],
                   let data = jsonResponse["data"] as? [String: Any],
                   let packageList = data["findPackageByUserIdSuccess"] as? [[String: Any]] {

                    let packages = packageList.compactMap { dict in
                        return Package(id: dict["id"] as? String ?? "",
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

                } else {
                    completion(NSError(domain: "com.EFD", code: 4, userInfo: [
                        NSLocalizedFailureReasonErrorKey: "Invalid response format"
                    ]), false, nil)
                }

            } catch let err {
                completion(err, false, nil)
                return
            }
        }

        task.resume()
    }

    
    class func modifyStatusPackageC(idP: String, status: String, completion: @escaping (Error?, Bool?) -> Void) {
        
        let url = "http://localhost:3000/graphql"
        
        guard let getAddURL = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: getAddURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Créez la requête GraphQL
        let query = """
        mutation {
            updatePackage(id: "\(idP)", updatePackageInput: { status: "\(status)" }) {
                id
                status
            }
        }
        """
        
        let json: [String: Any] = ["query": query]
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
                let responseJSON = try JSONSerialization.jsonObject(with: d, options: [])
                print("Response: \(responseJSON)")  // Déboguer la réponse ici si nécessaire
                completion(nil, true)
            } catch let err {
                completion(err, false)
                return
            }
        }
        
        task.resume()
    }

}
