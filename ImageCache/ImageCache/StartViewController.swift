//
//  StartViewController.swift
//  ImageCache
//
//  Created by Андрей Коноплев on 21/08/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var dataProvider = DataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "toLoadImage", let dest = segue.destination as? ViewController {
            dest.dataProvider = self.dataProvider
        }
    }
    
    
}
