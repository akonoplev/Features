//
//  ViewController.swift
//  InteractivePresentation
//
//  Created by Андрей Коноплев on 18/09/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.borderColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        startButton.layer.borderWidth = 0.5
    }


    @IBAction func letsGo(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "interactivVC") as! InteractiveVC
        let navController = UINavigationController()
        navController.viewControllers = [vc]
        navController.modalPresentationStyle = .overCurrentContext
        navController.navigationBar.isHidden = true
        self.present(navController , animated: true, completion: nil)
    }
}

