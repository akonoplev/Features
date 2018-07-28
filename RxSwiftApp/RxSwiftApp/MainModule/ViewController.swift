//
//  ViewController.swift
//  RxSwiftApp
//
//  Created by Андрей Коноплев on 21.07.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let router = MainRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reactive app"

    }

    
}

//MARK: - go to modules
extension ViewController {
    @IBAction func tapToGoFirstModule(_ sender: Any) {
        router.navigate(to: .first, navigationController: self.navigationController!)
    }
}






