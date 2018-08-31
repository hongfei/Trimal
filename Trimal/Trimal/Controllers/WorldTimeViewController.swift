//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeViewController: UIViewController, WorldTimeListDelegate {
    var worldTimeList = WorldTimeList()
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
        self.worldTimeList.loadViewData(timezones: self.timezones)

        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer, forMode: .commonModes)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let pin = self.view.pin
        self.worldTimeList.pin.all(pin.safeArea)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TimeCenter.toggleTimer(disableTimer: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }

    @IBAction func timerFired() {
        TimeCenter.timerPublishTime(time: Date())
    }
}
