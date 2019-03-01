//
//  Timer.swift
//  Timer
//
//  Created by Коноплев Андрей on 20/02/2019.
//  Copyright © 2019 Коноплев Андрей. All rights reserved.
//

import Foundation
import UIKit

protocol TimerDelegate: class {
    func didTimerEnd()-> Void
}

enum myTime {
    case timer
    case stopwatch
}

class SimpleTimer {
    typealias Tick = (String)->Void
    let mode: myTime
    
    
    var timer:Timer?
    var interval:TimeInterval
    var repeats:Bool
    var tick:Tick
    
    
    // start
    //for timer
    var startTime: Int
    
    //for stopwatch
    var currentTime: Int = 0
    
    var backgroundTime: Int?
    var delegate: TimerDelegate?
    
    init(startTime: Int, interval:TimeInterval, repeats:Bool = false, mode: myTime, onTick:@escaping Tick){
        self.interval = interval
        self.repeats = repeats
        self.tick = onTick
        self.mode = mode
        self.startTime = startTime
    }
    
    func start(){
        switch self.mode {
        case .timer:
            self.timer = Timer.scheduledTimer(timeInterval: self.interval, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        case .stopwatch:
            self.timer = Timer.scheduledTimer(timeInterval: self.interval, target: self, selector: #selector(self.updateStopWatch), userInfo: nil, repeats: true)
        }
        
        
        // work in background
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appReturnFromBackground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    func stop(){
        if(timer != nil){timer!.invalidate()}
    }
    
    @objc func updateTimer()-> Void {
        startTime -= 1
        if self.startTime <= 0 {
            self.stop()
            self.delegate?.didTimerEnd()
        } else {
            tick(makeTimeString(currentTime: self.startTime))
        }
    }
    
    @objc func updateStopWatch()-> Void {
        self.currentTime += 1
        
        if self.currentTime <= 0 {
            self.stop()
            self.delegate?.didTimerEnd()
        } else {
            tick(makeTimeString(currentTime: self.currentTime))
        }
    }
    
    //formatted time string
    func makeTimeString(currentTime: Int)-> String {
        if currentTime < 10 {
            return "0:0\(currentTime)"
        } else if currentTime >= 10 && currentTime < 60 {
            return "0:\(currentTime)"
        } else if currentTime >= 60 {
            let h = (currentTime % 3600) / 60
            let m = (currentTime % 3600) % 60
            if m >= 10 {
                return "\(h):\(m)"
            } else {
                return "\(h):0\(m)"
            }
        }
        return ""
    }
    
    @objc func appMovedToBackground() -> Void {
        self.backgroundTime = Int(NSDate().timeIntervalSince1970)
    }
    
    @objc func appReturnFromBackground()-> Void {
        guard let backgroundTime = self.backgroundTime else { return }
        
        let currentTime = Int(NSDate().timeIntervalSince1970)
        let substractionTime = currentTime - backgroundTime
        
        switch mode {
        case .timer:
            self.startTime -= substractionTime
            updateTimer()
        case .stopwatch:
            self.currentTime += substractionTime
            updateStopWatch()
        }
        
    }
}
