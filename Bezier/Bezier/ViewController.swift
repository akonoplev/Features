//
//  ViewController.swift
//  Bezier
//
//  Created by User on 27/04/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didTap(tapGR: )))
        self.view.addGestureRecognizer(tapGR)
    }

    @objc func didTap(tapGR: UITapGestureRecognizer) {
        let tapPoint = tapGR.location(in: self.view)
        let myView = MyView(origin: tapPoint)
        self.view.addSubview(myView)
    }
}


