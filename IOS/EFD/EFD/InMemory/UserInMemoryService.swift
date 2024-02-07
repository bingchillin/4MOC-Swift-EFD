//
//  UserMemoryService.swift
//  EFD
//
//  Created by Gabriel on 2/7/24.
//

import Foundation


class UserInMemoryService {
    static let shared = UserInMemoryService()
    
    private var cache: User?

    // Fonction pour stocker un utilisateur dans le cache
    func setValue(_ value: User) {
        cache = value
    }

    // Fonction pour récupérer l'utilisateur du cache
    func userValue() -> User? {
        return cache
    }
}
