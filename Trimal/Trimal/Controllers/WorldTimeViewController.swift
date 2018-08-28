//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeViewController: UIViewController {
    var worldTimeList = WorldTimeList()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.yellow

        self.worldTimeList.locales = [Locale(identifier: "en_US_POSIX")]
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let pin = self.view.pin
        self.worldTimeList.pin.all(pin.safeArea)
    }
}
