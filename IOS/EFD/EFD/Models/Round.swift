//
//  Round.swift
//  EFD
//
//  Created by kenny on 31/01/2024.
//

import Foundation

class Round:CustomStringConvertible{
    var title: String
    var status: String
    var deliveryId: String?
    var packageId: String?
    
    var description: String{
        return "title: \(title), status: \(status), deliveryId: \(deliveryId ?? ""), packageId: \(packageId ?? "")"
    }
    
    init(title:String, status: String, deliveryId: String?, packageId: String?) {
        self.title = title
        self.status = status
        self.deliveryId = deliveryId
        self.packageId = packageId
    }
}
