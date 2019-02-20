//
//  Timer.swift
//  Timer
//
//  Created by Коноплев Андрей on 20/02/2019.
//  Copyright © 2019 Коноплев Андрей. All rights reserved.
//

import Foundation

class SimpleTimer {
    typealias Tick = (String)->Void
    var timer:Timer?
    var interval:TimeInterval
    var repeats:Bool
    var tick:Tick
    // start
    var startTime: Int
    
    init(startTime: Int, interval:TimeInterval, repeats:Bool = false, onTick:@escaping Tick){
        self.interval = interval
        self.repeats = repeats
        self.tick = onTick
        self.startTime = startTime
    }
    
    func start(){
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func stop(){
        if(timer != nil){timer!.invalidate()}
    }
    
    @objc func update() {
        startTime -= 1
        if self.startTime == 0 {
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
    
}
