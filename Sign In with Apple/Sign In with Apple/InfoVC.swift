//
//  InfoVC.swift
//  Sign In with Apple
//
//  Created by Andrei Konoplev on 08/10/2019.
//  Copyright © 2019 Коноплев Андрей. All rights reserved.
//

import Foundation
import UIKit

class InfoVC: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = user?.debugDescription
    }
    
}
