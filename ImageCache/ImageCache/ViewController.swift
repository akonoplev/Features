//
//  ViewController.swift
//  ImageCache
//
//  Created by Андрей Коноплев on 21/08/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var dataProvider: DataProvider!
    
    private var image: UIImage? {
        didSet {
            imageView.image = image
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let urlString = "https://images7.alphacoders.com/671/671281.jpg"
        let url = URL(string: urlString)!
        
        dataProvider.downloadImage(url: url) { (image) in
            self.image = image
        }
        
    }
    
    deinit {
        print("controller deinit")
    }




}

