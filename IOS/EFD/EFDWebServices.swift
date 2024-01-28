//
//  EFDWebServices.swift
//  EFD
//
//  Created by Gabriel on 1/28/24.
//

import Foundation
import UIKit

class EFDWebServices{
    
    class func addUser(username : String, email: String, password : String, completion: @escaping (Error?, Bool?) -> Void){
    
        let url = "http://localhost:27017/user"
        
        guard let getAddURL = URL(string: url) else{
            return
        }
        
        print(" - ", username, " - ", email, " - ", password)
        var request = URLRequest(url: getAddURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let json: [String: Any] = ["name": username,
                                   "email": email,
                                   "password": password,
                                   "role": "admin"]

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
