//
//  File.swift
//  Bezier
//
//  Created by User on 07/05/2018.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

class Counter {
    static let sharedInstance = Counter()
    var count = 1
    
    func add1() {
        count += 1
    }
}
