//
//  Package.swift
//  EFD
//
//  Created by kenny on 31/01/2024.
//

import Foundation

class Package: CustomStringConvertible{
    let name: String
    let status: String
    let proof: String
    var description: String{
        return "name: \(name),status: \(status),proof: \(proof)"
    }
    
    init(name: String, status: String, proof: String) {
        self.name = name
        self.status = status
        self.proof = proof
    }
}
