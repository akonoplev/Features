//
//  Model.swift
//  Decodable
//
//  Created by User on 15/06/2018.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

struct RawServerResponse : Decodable {
    let photos: SecondModel
}

struct Model: Decodable {
    let id: String
    let owner: String
    let secret: String
    
    init(json: [String: Any]) {
        id = json["id"] as? String ?? ""
        owner = json["owner"] as? String ?? ""
        secret = json["secret"] as? String ?? ""
    }
}

struct SecondModel: Decodable {
    let page: String?
    let total: String?
    let photo: [Model]
}

