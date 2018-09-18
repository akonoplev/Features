//
//  InteractiveVC.swift
//  InteractivePresentation
//
//  Created by Андрей Коноплев on 18/09/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class InteractiveVC: UIViewController {

    let backView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addRecognaizer()
    }
}

//MARK: - Recognaizer
extension InteractiveVC {
    func addRecognaizer() {
        let recognaizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(rec: )))
        self.backView.addGestureRecognizer(recognaizer)
    }
    
    @objc func handlePan(rec: UIPanGestureRecognizer) {
        let translation = rec.translation(in: self.backView)
        
        if self.backView.frame.origin.y >= 0 && translation.y >= 0 {
            self.backView.center.y =  self.backView.bounds.height / 2 + translation.y
            
            if self.backView.frame.width > UIScreen.main.bounds.width - 40 {
                self.backView.frame.size.width = self.backView.bounds.width - translation.y / 512
                self.backView.frame.origin.x += translation.y / 1024
            }
        }

        
        if rec.state == .ended {
            if translation.y > self.backView.bounds.height / 3 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.backView.frame.origin.y = UIScreen.main.bounds.height
                }) { (finished) in
                    self.dismiss(animated: false, completion: nil)
                }
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.backView.frame = self.view.bounds
                }
            }
        }
    }
}

//MARK: - configure
extension InteractiveVC {
    func setUpView() {
        self.navigationItem.title = "2"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        configureView()
        
        UIView.animate(withDuration: 0.5) {
            self.backView.frame = self.view.bounds
        }
    }
    
    func configureView() {
        backView.frame = CGRect(x: 30, y: self.view.frame.size.height, width: self.view.frame.size.width - 60, height: self.view.frame.height)
        backView.backgroundColor = UIColor.red
        self.view.addSubview(backView)
    }
    
    @objc func close() {
        self.navigationController?.dismiss(animated: false, completion: nil)
    }
}
