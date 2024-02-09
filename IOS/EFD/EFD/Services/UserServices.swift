//
//  UserService.swift
//  EFD
//
//  Created by Gabriel on 2/7/24.
//

import Foundation

protocol UserService{
    func setValue(_ value: User, _ completion : @escaping(Error?) -> Void)
    func getAll(_ completion : @escaping(Error?, [User]?) -> Void)
    func getById(_ userId : String, _ completion: @escaping (Error?, User?) -> Void)
    func clear(_ completion: @escaping (Error?) -> Void)
}

class UserServices {
    class func getAllUsers(completion: @escaping (Error?, [User]?) -> Void) {
        let url = "http://localhost:3000/user"
        
        guard let getUsersURL = URL(string: url) else {
            completion(NSError(domain: "com.YourApp", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "URL invalide"
            ]), nil)
            return
        }
        
        var request = URLRequest(url: getUsersURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(error, nil)
                return
            }
            
            do {
                if let userList = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    let users = userList.map { dict in
                        return User(
                            id: dict["_id"] as? String ?? "",
                            name: dict["name"] as? String ?? "",
                            email: dict["email"] as? String ?? "",
                            password: dict["password"] as? String ?? "",
                            role: dict["role"] as? String ?? "",
                            latitude: dict["latitude"] as? Double,
                            longitude: dict["longitude"] as? Double
                        )
                    }
                    completion(nil, users)
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

}


