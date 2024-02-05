//
//  User.swift
//  EFD
//
//  Created by Gabriel on 2/1/24.
//

import Foundation


class User: CustomStringConvertible{
    let name: String
    let email: String
    let password: String
    let role: String
    
    var description: String{
        return "name: \(name),email: \(email),role: \(role)"
    }
    
    init(name: String, email: String, password: String, role: String) {
        self.name = name
        self.email = email
        self.password = password
        self.role =  role
    }
}
