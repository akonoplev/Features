//
//  MyView.swift
//  Bezier
//
//  Created by User on 27/04/2018.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

class MyView: UIView {
    let size: CGFloat = 150.0
    let lineWidth: CGFloat = 3
    
    var view: UIBezierPath!
    var viewColor: UIColor!
    var fractalCount = 1
    
    init(origin: CGPoint) {
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        self.center = origin
        self.viewColor = randomColor()
        self.view = randomView()
        self.backgroundColor = UIColor.clear
        self.view = randomView()
        initGestureRecognize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        //set fill color of rect
        self.viewColor.setFill()
        self.view.fill()
        //set insetColorlone

        
        //add hatch
        var name = "hatch"
        if arc4random() % 2 == 0 {
            name = "cross-hatch"
        }
        
        let color = UIColor(patternImage: UIImage(named: name)!)
        color.setFill()
        
        if arc4random() % 2 == 0 {
            self.view.fill()
        }
        
        self.view.lineWidth = self.lineWidth
        UIColor.black.setStroke()
        self.view.stroke()
    }
    
}

extension MyView {
    func initGestureRecognize() {
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        addGestureRecognizer(panGR)

        let pinchGR = UIPinchGestureRecognizer(target: self, action: #selector(didPinch))
        addGestureRecognizer(pinchGR)
        
        let rotationGR = UIRotationGestureRecognizer(target: self, action: #selector(didRotate))
        addGestureRecognizer(rotationGR)
    }
    
    @objc func didPan(panGR: UIPanGestureRecognizer) {
        self.superview?.bringSubview(toFront: self)
        var translation = panGR.translation(in: self)
        self.center.x += translation.x
        self.center.y += translation.y
        
        translation = translation.applying(self.transform)
        
        panGR.setTranslation(CGPoint(x: 0, y: 0), in: self)
    }
    
    @objc func didPinch(pinchGR: UIPinchGestureRecognizer) {
        self.superview?.bringSubview(toFront: self)
        
        let scale = pinchGR.scale
        self.transform = CGAffineTransform(scaleX:scale, y: scale)
        
        pinchGR.scale = 1.0
    }
    
    @objc func didRotate(rotationGR: UIRotationGestureRecognizer) {
        self.superview?.bringSubview(toFront: self)
        let rotation = rotationGR.rotation
        self.transform = CGAffineTransform(rotationAngle: rotation)
        rotationGR.rotation = 0.0
    }
}

// random color
extension MyView {
    func randomColor() -> UIColor {
        let hue: CGFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        return UIColor(hue: hue, saturation: 0.8, brightness: 1.0, alpha: 0.8)
    }
}
// random bezierPath

extension MyView {
    func randomView()-> UIBezierPath {
        let insetRect = self.bounds.insetBy(dx: lineWidth, dy: lineWidth)
//        let shapeType = arc4random() % 2
        let shapeType = 0
        
        switch shapeType {
        case 0: return fractalPathInRect(rect: insetRect)
//        case 1: return UIBezierPath(ovalIn: insetRect)
//        case 2: return fourAngle(rect: insetRect)
//        case 3: return regularPolygonInRect(rect: insetRect)
//        case 4: return makeStars(rect: insetRect)
//        case 5:  return UIBezierPath(roundedRect: insetRect, cornerRadius: 40)
        default: return trianglePathInRect(rect: insetRect)

        }
    }
    
    //make triangle
    func trianglePathInRect(rect: CGRect)-> UIBezierPath {
        let path = UIBezierPath()
        //move point on center y
        path.move(to: CGPoint(x: rect.width / 2.0, y: rect.origin.y ))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: rect.origin.x, y: rect.height))
        
        path.close()
        return path
    }

    func fourAngle(rect: CGRect)-> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: rect.width / 4, y: rect.origin.y))
        
        path.addLine(to: CGPoint(x: rect.width , y: rect.height / 4))
        path.addLine(to: CGPoint(x: rect.width / 2, y: rect.width))
        path.addLine(to: CGPoint(x: rect.origin.x, y: rect.height / 5))
        path.addLine(to: CGPoint(x: rect.width / 4, y: rect.origin.y))
        
        path.close()
        return path
        
    }
}

//MARK: - make manyAngleFigure with random count angle

extension MyView {
    func pointFrom(angel: CGFloat, radius: CGFloat, offset: CGPoint)-> CGPoint {
        return CGPoint(x: radius * cos(angel) + offset.x , y: radius * sin(angel) + offset.y)
    }
    
    func regularPolygonInRect(rect: CGRect)-> UIBezierPath {
        let degree = arc4random() % 10 + 3
        let path = UIBezierPath()
        let center = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)
        
        var angle: CGFloat = -CGFloat(.pi / 2.0)
        let angleIncrement = CGFloat(.pi * 2.0 / Double(degree))
        let radius = rect.width / 2
        path.move(to: pointFrom(angel: angle, radius: radius, offset: center))
        
        for _ in 1...degree - 1 {
            angle += angleIncrement
            path.addLine(to: pointFrom(angel: angle, radius: radius, offset: center))
        }
        path.close()
        return path
    }
}

//MARK : make stars
extension MyView {
    func makeStars(rect: CGRect)-> UIBezierPath {
        let path = UIBezierPath()
        let starExtrussion: CGFloat = 30.0
        
        let center = CGPoint(x: rect.width / 2, y: rect.width / 2)
        let poitsOfStar = 5 + arc4random() % 10
        
        var angle: CGFloat = -CGFloat(.pi / 2.0)
        let angleIncrement = CGFloat(.pi * 2.0 / Double(poitsOfStar))
        let radius = rect.width / 2.0
        
        var firstPoint = true
        for _ in 1...poitsOfStar {
            let point = pointFrom(angel: angle , radius: radius, offset: center)
            let nextPoint = pointFrom(angel: angle + angleIncrement, radius: radius, offset: center)
            let midPoint = pointFrom(angel: angle + angleIncrement / 2.0, radius: starExtrussion, offset: center)
            
            
            if firstPoint {
                firstPoint = false
                path.move(to: point)
            }
            path.addLine(to: midPoint)
            path.addLine(to: nextPoint)
            angle += angleIncrement
        }
        path.close()
        return path
    }
}

//MARK: - add fractals

extension MyView {
    func addDetailToFractralPath(center: CGPoint, radius: CGFloat, path: UIBezierPath, iterations: Int) {
        if iterations == 0 {
            return
        }
        
        var angle:CGFloat = -CGFloat(.pi / 2.0)
        let angleIncrement = CGFloat(.pi * 2.0 / Double(3))
        path.append(UIBezierPath(ovalIn:  CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)))
        
        for _ in 1...3 {
            let point = pointFrom(angel: angle, radius: radius, offset: center)
            addDetailToFractralPath(center: point, radius: radius / 2.0, path: path, iterations: iterations - 1)
            angle += angleIncrement
        }
        path.close()
    }
    
    func fractalPathInRect(rect: CGRect) -> UIBezierPath {
        let path: UIBezierPath = UIBezierPath()
        
        addDetailToFractralPath(center: CGPoint(x: rect.width / 2, y: rect.height / 2), radius: 35.0, path: path, iterations: Counter.sharedInstance.count)
        Counter.sharedInstance.add1()
        return path
    }

}


