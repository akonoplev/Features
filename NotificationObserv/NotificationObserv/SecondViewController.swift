//
//  SecondViewController.swift
//  NotificationObserv
//
//  Created by User on 18/05/2018.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

let mysNotificationKey = "foxcards.ru"

class SecondViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    var i = 0
    
    @IBAction func pressNotified(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(mysNotificationKey), object: nil, userInfo: ["count": i])
        self.textLabel.text = "Нотификация"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(DoThisWhenNotified), name: NSNotification.Name(rawValue: mysNotificationKey), object: nil)
        
    }
    
    @objc func DoThisWhenNotified() {
        print("notification!!!!!!!!!")
    }
}
