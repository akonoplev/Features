//
//  User.swift
//  Sign In with Apple
//
//  Created by Andrei Konoplev on 08/10/2019.
//  Copyright © 2019 Коноплев Андрей. All rights reserved.
//

import Foundation
import AuthenticationServices
struct User {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    
    init(credentials: ASAuthorizationAppleIDCredential) {
        self.id = credentials.user
        self.firstName = credentials.fullName?.givenName ?? ""
        self.lastName = credentials.fullName?.familyName ?? ""
        self.email = credentials.email ?? ""
    }
}

extension User: CustomDebugStringConvertible {
    var debugDescription: String {
        return """
        ID: \(id),
        firstName: \(firstName),
        lastName: \(lastName),
        email: \(email)
        """
    }
}
