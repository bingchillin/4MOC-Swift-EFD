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


