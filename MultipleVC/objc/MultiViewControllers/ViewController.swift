//
//  ViewController.swift
//  MultiViewControllers
//
//  Created by Коноплев Андрей on 09/11/2018.
//  Copyright © 2018 Коноплев Андрей. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
    }

    func setUpViewControllers() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let firstVC = storyboard.instantiateViewController(withIdentifier: "firstChildVC") as! FirstChildVC
        let secondVC = storyboard.instantiateViewController(withIdentifier: "secondChildVC") as! SecondChildVC
        
        self.addChild(firstVC)
        self.view.addSubview(firstVC.view)
        firstVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.frame.height / 2)
        firstVC.didMove(toParent: self)
        
        self.addChild(secondVC)
        self.view.addSubview(secondVC.view)
        secondVC.view.frame = CGRect(x: 0, y: self.view.frame.height / 2, width: UIScreen.main.bounds.width, height: self.view.frame.height / 2)
        secondVC.didMove(toParent: self)
    }
}

