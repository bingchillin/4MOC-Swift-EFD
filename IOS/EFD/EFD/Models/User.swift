//
//  User.swift
//  EFD
//
//  Created by Gabriel on 2/1/24.
//

import Foundation


class User: CustomStringConvertible{
    let id: String?
    var name: String
    var email: String
    var password: String
    var role: String
    
    var description: String{
        return "name: \(name),email: \(email),role: \(role)"
    }
    
    init(id: String?, name: String, email: String, password: String, role: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.role =  role
    }
}
