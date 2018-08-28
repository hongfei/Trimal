//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeViewController: UIViewController {
    var worldTimeList = WorldTimeList()

    override var navigationItem: UINavigationItem {
        let navItem = UINavigationItem()
        navItem.title = "Time"
        return navItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.92, green: 0.97, blue: 0.97, alpha: 1)

        self.view.addSubview(self.worldTimeList)
        self.worldTimeList.loadViewData(timezones: MockData.timezones)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let pin = self.view.pin
        self.worldTimeList.pin.all(pin.safeArea)
    }
}
