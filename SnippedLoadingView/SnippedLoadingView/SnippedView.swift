//
//  SnippedView.swift
//  SnippedLoadingView
//
//  Created by User on 19/07/2018.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

// swift 4

class SnippedView: UIView {
    
    let circularLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        circularLayer.lineWidth = 4.0
        circularLayer.fillColor = nil
        self.layer.addSublayer(circularLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - animations
    let inAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        return animation
    }()
    
    let outAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.5
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        return animation
    }()
    
    let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0.0
        animation.toValue = 2 * Float.pi
        animation.duration = 2.0
        animation.repeatCount = MAXFLOAT
        
        return animation
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: bounds.midX, y: bounds.midY + 50)
        let radius: CGFloat = 20.0
        let arcPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: radius, startAngle: CGFloat(Float.pi / 2), endAngle: CGFloat(Float.pi / 2 + (2 * Float.pi)), clockwise: true)
        circularLayer.position = center
        circularLayer.path = arcPath.cgPath
        animateProgressView()
        circularLayer.add(rotationAnimation, forKey: "rotateAnimation")
    }
    
    func animateProgressView() {
        circularLayer.removeAnimation(forKey: "strokeAnimation")
        circularLayer.strokeColor = #colorLiteral(red: 0.7490196078, green: 0.6235294118, blue: 0.337254902, alpha: 1)
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1.0 + outAnimation.beginTime
        strokeAnimationGroup.repeatCount = 1000
        strokeAnimationGroup.animations = [inAnimation, outAnimation]
        circularLayer.add(strokeAnimationGroup, forKey: "strokeAnimation")
    }
}
