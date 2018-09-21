//
// Created by Zhou, Hongfei on 9/21/18.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class NewTimeZoneNickNameViewController: UIViewController {
    var selectedCity: String = ""
    var selectedTimeZone: TimeZone!

    var selectedCityLabel: UILabel = UILabel()
    var timeZoneLabel: UILabel = UILabel()
    var currentTimeLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelNewTimeZone))
        self.view.backgroundColor = .white

        self.selectedCityLabel.text = self.selectedCity
        self.selectedTimeZone = TimeZoneService.getTimeZone(for: self.selectedCity)
        self.view.addSubview(self.selectedCityLabel)

        self.timeZoneLabel.text = self.selectedTimeZone.description
        self.view.addSubview(self.timeZoneLabel)

        self.currentTimeLabel.text = DateUtil.formatTime(time: DateUtil.currentTime(), with: self.selectedTimeZone)
        self.view.addSubview(self.currentTimeLabel)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let pin = self.view.pin
        self.selectedCityLabel.pin.horizontally(pin.safeArea).top(pin.safeArea).marginTop(20).height(40)
        self.timeZoneLabel.pin.horizontally(pin.safeArea).below(of: self.selectedCityLabel).height(20)
        self.currentTimeLabel.pin.horizontally(pin.safeArea).below(of: self.timeZoneLabel).height(20)
    }

    @IBAction func cancelNewTimeZone() {
        self.navigationController?.dismiss(animated: true)
    }
}
