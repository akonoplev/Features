//
//  Timer.swift
//  Timer
//
//  Created by Коноплев Андрей on 20/02/2019.
//  Copyright © 2019 Коноплев Андрей. All rights reserved.
//

import Foundation
import UIKit

class SimpleTimer {
    typealias Tick = (String)->Void
    var timer:Timer?
    var interval:TimeInterval
    var repeats:Bool
    var tick:Tick
    // start
    var startTime: Int
    
    var backgroundTime: Int?
    
    init(startTime: Int, interval:TimeInterval, repeats:Bool = false, onTick:@escaping Tick){
        self.interval = interval
        self.repeats = repeats
        self.tick = onTick
        self.startTime = startTime
    }
    
    func start(){
        self.timer = Timer.scheduledTimer(timeInterval: self.interval, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        // work in background
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appReturnFromBackground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func stop(){
        if(timer != nil){timer!.invalidate()}
    }
    
    @objc func update() {
        startTime -= 1
        if self.startTime <= 0 {
            self.stop()
            tick("0")
        } else if self.startTime < 60 {
            tick("\(startTime)")
        } else if startTime >= 60 {
            let h = (startTime % 3600) / 60
            let m = (startTime % 3600) % 60
            tick("\(h) : \(m)")
        }
    }
    
    @objc func appMovedToBackground() -> Void {
        self.backgroundTime = Int(NSDate().timeIntervalSince1970)
    }
    
    @objc func appReturnFromBackground()-> Void {
        guard let backgroundTime = self.backgroundTime else { return }
        
        let currentTime = Int(NSDate().timeIntervalSince1970)
        let substractionTime = currentTime - backgroundTime
        self.startTime -= substractionTime
        update()
    }
}
