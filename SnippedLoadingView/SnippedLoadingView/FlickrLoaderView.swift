//
//  FlickrLoaderView.swift
//  SnippedLoadingView
//
//  Created by Andrei Konoplev on 04.03.2020.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation
import UIKit

class FlickrLoaderView: UIView {
    
    let redView = UIView()
    let blueView = UIView()
    
    var topFlag: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        isHidden = true
        blueView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blueView)
        
        blueView.backgroundColor = Colors.blue
        blueView.layer.cornerRadius = Layout.Circle.cornerRadius
        blueView.clipsToBounds = true
        blueView.frame.origin = CGPoint(x: 0, y: self.bounds.midY - CGFloat(Layout.Circle.width / 2))
        blueView.frame.size = CGSize(width: Layout.Circle.width, height: Layout.Circle.width)
        

        redView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(redView)
        
        redView.backgroundColor = Colors.red
        redView.layer.cornerRadius = Layout.Circle.cornerRadius
        redView.clipsToBounds = true
        redView.frame.origin = CGPoint(x: self.bounds.width - CGFloat(Layout.Circle.width), y: self.bounds.midY - CGFloat(Layout.Circle.width / 2))
        redView.frame.size = CGSize(width: Layout.Circle.width, height: Layout.Circle.width)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.startAnimate()
        }
    }
}

//MARK: - animation
extension FlickrLoaderView {
    func startAnimate() {
        
        isHidden = false
        redView.layer.zPosition = topFlag ? 1000 : 999
        blueView.layer.zPosition = topFlag ? 999 : 1000
        topFlag = !topFlag
        
        UIView.animate(withDuration: Layout.Animations.reverseDuration, animations: {
            let redCenter = self.redView.center
            let blueCenter = self.blueView.center
            
            self.redView.center = blueCenter
            self.blueView.center = redCenter

            self.layoutIfNeeded()
        }) { (finished) in
            self.startAnimate()
        }
    }
    
    func stopAnimate() {
        isHidden = true
    }
}

//MARK: -
extension FlickrLoaderView {
    enum Layout {
        enum Circle {
            static let width = 20
            static var cornerRadius: CGFloat = {
                return CGFloat(Layout.Circle.width / 2)
            }()
        }
        
        enum Animations {
            static let reverseDuration = 0.7
        }
    }
    
    enum Colors {
        static let blue = UIColor.blue
        static let red = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
}
