//
//  ViewController.swift
//  NotificationObserv
//
//  Created by User on 18/05/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(doWhenNotified), name: Notification.Name(mysNotificationKey), object: nil)
        NotificationCenter.default.addObserver(forName: Notification.Name(mysNotificationKey), object: nil, queue: nil, using: catchNotification)
    }
    
    func catchNotification(notification: Notification)-> Void {
        guard let count = notification.userInfo!["count"] else { return }
        textLabel.text = "\(count)"
        
    }
    
    @IBAction func goNext(_ sender: Any) {
        performSegue(withIdentifier: "a", sender: nil)
    }

//    @objc func doWhenNotified() {
//        print("Нотификация прошла успешно")
//        textLabel.text = "Ураааа"
//    }
}

