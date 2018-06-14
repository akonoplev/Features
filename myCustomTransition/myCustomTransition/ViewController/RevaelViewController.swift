//
//  RevaelViewController.swift
//  myCustomTransition
//
//  Created by User on 12/04/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class RevaelViewController: UIViewController {
    
    var interactionTransitionController: InteractionTransitionController?

    var num: Int?
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactionTransitionController = InteractionTransitionController(viewController: self)
        if let nums = num {
             numberLabel.text = String(describing: nums)
        }
       
        
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


