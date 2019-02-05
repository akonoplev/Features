//
//  ViewController.swift
//  aStackView
//
//  Created by Коноплев Андрей on 05/02/2019.
//  Copyright © 2019 Коноплев Андрей. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapFirst(_ sender: Any) {
        self.performSegue(withIdentifier: "firstSegue", sender: nil)
    }


}

