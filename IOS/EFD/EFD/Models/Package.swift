//
//  Package.swift
//  EFD
//
//  Created by kenny on 31/01/2024.
//

import Foundation

class Package: CustomStringConvertible{
    let id: String
    var name: String
    var status: String
    var proof: String
    var latitude: Double?
    var longitude: Double?
    var idUserDelivery: String?
    var isAffected: Bool
    var idUserClient: String
    
    var description: String{
        return "name: \(name),status: \(status),proof: \(proof), latitude: \(latitude ?? 0), longitude: \(longitude ?? 0)"
    }
    
    init(id: String, name: String, status: String, proof: String, latitude: Double?, longitude: Double?, idUserDelivery: String?, isAffected: Bool, idUserClient: String ) {
        self.id = id
        self.name = name
        self.status = status
        self.proof = proof
        self.latitude = latitude
        self.longitude = longitude
        self.idUserDelivery = idUserDelivery
        self.isAffected = isAffected
        self.idUserClient = idUserClient
    }
}
