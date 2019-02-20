//
//  ViewController.swift
//  Timer
//
//  Created by Коноплев Андрей on 20/02/2019.
//  Copyright © 2019 Коноплев Андрей. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timer = SimpleTimer.init(startTime: 600, interval: 1.0, repeats: true) { [weak self] (time) in
            guard let sself = self else { return }
            sself.timerLabel.text = time
        }
        timer.start()
    }


}

