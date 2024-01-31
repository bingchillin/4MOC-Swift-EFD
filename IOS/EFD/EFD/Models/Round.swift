//
//  Round.swift
//  EFD
//
//  Created by kenny on 31/01/2024.
//

import Foundation

class Round:CustomStringConvertible{
    
    let status: String
    let package: [String]
    
    var description: String{
        return ""
    }
    
    init(status: String, package: [String]) {
        self.status = status
        self.package = package
    }
}
