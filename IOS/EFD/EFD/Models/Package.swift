//
//  Package.swift
//  EFD
//
//  Created by kenny on 31/01/2024.
//

import Foundation

class Package: CustomStringConvertible{
    var name: String
    var status: String
    var proof: String
    var latitude: Double?
    var longitude: Double?
    
    var description: String{
        return "name: \(name),status: \(status),proof: \(proof), latitude: \(latitude ?? 0), longitude: \(longitude ?? 0)"
    }
    
    init(name: String, status: String, proof: String, latitude: Double?, longitude: Double?) {
        self.name = name
        self.status = status
        self.proof = proof
        self.latitude = latitude
        self.longitude = longitude
    }
}
