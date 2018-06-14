//
//  ViewController.swift
//  KickAssProgress
//
//  Created by User on 08/06/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var shapeLayer = CAShapeLayer()
    var pulsatingLayer: CAShapeLayer!
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationCenterObservers()
        self.view.backgroundColor = UIColor.black
        // pulsare layer
        pulsatingLayer = createShapeLayer(strokeColor: UIColor.clear, fillColor: #colorLiteral(red: 1, green: 0.1372168362, blue: 0.2936674356, alpha: 0.5688142123))
        view.layer.addSublayer(pulsatingLayer)
        animatePulsarLayer()

        //create track lauer
        let trackLayer = createShapeLayer(strokeColor: UIColor.lightGray, fillColor: UIColor.black)
        trackLayer.fillColor = UIColor.black.cgColor
        view.layer.addSublayer(trackLayer)
        
        //shape layer
        shapeLayer = createShapeLayer(strokeColor: #colorLiteral(red: 0.9158259034, green: 0, blue: 0, alpha: 1), fillColor: UIColor.clear)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        view.layer.addSublayer(shapeLayer)
        
        //label
        view.addSubview(percentLabel)
        percentLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentLabel.center = view.center
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate func beginDownLoad() {

        let url = URL(string: "https://s.yimg.com/uy/build/images/jobs/team-2018.jpg")
        let operationQueue = OperationQueue()
        let confiiguretion = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: confiiguretion, delegate: self, delegateQueue: operationQueue)
        guard let url1 = url else { return }
        let downloadTask = urlSession.downloadTask(with: url1)
        downloadTask.resume()
    }
    
    fileprivate func animation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue =
        //basicAnimation.duration = 0.5
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urBasic")
    }
    
    private func animatePulsarLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.2
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey: "pulsing")
        
    }
    
    @objc private func handleTap() {
        beginDownLoad()
        //animation()
    }
}


extension ViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finished download")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percent = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            self.percentLabel.text = "\(Int(percent * 100))% "
            self.shapeLayer.strokeEnd = percent
        }
        print(percent)
    }
    
    private func setupNotificationCenterObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleComplete), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc func handleComplete() {
        animatePulsarLayer()
    }
}

extension ViewController {
    private func createShapeLayer(strokeColor: UIColor, fillColor: UIColor)-> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle:  0, endAngle: CGFloat.pi * 2, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 10
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
        layer.position = view.center
        return layer
    }
}

