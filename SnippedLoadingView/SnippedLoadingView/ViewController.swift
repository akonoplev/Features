//
//  ViewController.swift
//  SnippedLoadingView
//
//  Created by User on 19/07/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let style: LoaderStyle = .flickr
    var loader: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch style {
        case .snipped:
            let view = SnippedView(frame: self.view.bounds)
            view.animateProgressView()
            self.view.addSubview(view)
        case .flickr:
            let flickrLoader = FlickrLoaderView(frame: .init(x: 0, y: 0, width: 100, height: 50))
            flickrLoader.center = view.center
            view.addSubview(flickrLoader)
            self.loader = flickrLoader
        }
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loader?.center = view.center
    }
}

enum LoaderStyle {
    case snipped
    case flickr
}

