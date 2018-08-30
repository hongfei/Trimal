//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeViewController: UIViewController {
    var worldTimeList = WorldTimeList()
    var calendar = Calendar.current
    var timezones: [UserTimeZone] = MockData.timezones
    var timer: Timer!

    override var navigationItem: UINavigationItem {
        let navItem = UINavigationItem()
        navItem.title = "Time"
        return navItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.92, green: 0.97, blue: 0.97, alpha: 1)
        self.view.addSubview(self.worldTimeList)

        let current = Date()
        self.worldTimeList.loadViewData(time: current, timezones: self.timezones)

        let seconds = 60 - calendar.component(.second, from: current)
        self.timer = Timer(fire: calendar.date(byAdding: .second, value: seconds, to: current)!, interval: 60, repeats: true, block: timerFired)
        RunLoop.main.add(self.timer, forMode: .commonModes)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let pin = self.view.pin
        self.worldTimeList.pin.all(pin.safeArea)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }

    @IBAction func timerFired(_ timer: Timer) {
        let currentTime = Date()
        self.worldTimeList.loadViewData(time: currentTime, timezones: self.timezones)
    }
}
