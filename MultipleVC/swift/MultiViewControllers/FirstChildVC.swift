//
//  FirstChildVC.swift
//  MultiViewControllers
//
//  Created by Коноплев Андрей on 09/11/2018.
//  Copyright © 2018 Коноплев Андрей. All rights reserved.
//

import UIKit

class FirstChildVC: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textLabel.text = "Выберите страну или регион, чтобы контент и онлайн-товары соответствовали вашему местоположению."
    }
    
}
