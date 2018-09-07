//
// Created by Hongfei on 2018/8/30.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import Foundation

class TimeCenterService {
    public static var storedTime: Date = Date()
    static var timerDisabled: Bool = false
    static var listeners: [Int:TimeListener] = [:]

    public static func publishNewTime(time: Date) {
        storedTime = time
        for listener in listeners.values {
            listener.onTimeUpdate(time: time)
        }
    }

    public static func toggleTimer(disableTimer: Bool) {
        timerDisabled = disableTimer
    }

    public static func timerPublishTime(time: Date) {
        if !timerDisabled {
            publishNewTime(time: time)
        }
    }

    public static func register(sender: Int, listener: TimeListener) {
        listeners[sender] = listener
    }

}


protocol TimeListener {
    func onTimeUpdate(time: Date)
}