//
//  ViewController.swift
//  SnippedLoadingView
//
//  Created by User on 19/07/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let view = SnippedView(frame: self.view.bounds)
        view.animateProgressView()
        self.view.addSubview(view)
    }



}

