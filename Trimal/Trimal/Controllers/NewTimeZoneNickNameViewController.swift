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
    var nickNameField: UITextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.selectedCityLabel.text = self.selectedCity
        self.selectedTimeZone = TimeZoneService.getTimeZone(for: self.selectedCity)
        self.view.addSubview(self.selectedCityLabel)

        self.timeZoneLabel.text = self.selectedTimeZone.description
        self.view.addSubview(self.timeZoneLabel)

        self.currentTimeLabel.text = DateUtil.formatTime(time: DateUtil.currentTime(), with: self.selectedTimeZone)
        self.view.addSubview(self.currentTimeLabel)

        self.nickNameField.placeholder = "Optional"
        self.view.addSubview(self.nickNameField)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveNewTimeZone))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.selectedCityLabel.pin.horizontally(10%).top().marginTop(20).height(40)
        self.timeZoneLabel.pin.horizontally(10%).below(of: self.selectedCityLabel).height(20)
        self.currentTimeLabel.pin.horizontally(10%).below(of: self.timeZoneLabel).height(20)
        self.nickNameField.pin.horizontally(10%).below(of: self.currentTimeLabel).height(20)
    }

    @IBAction func saveNewTimeZone() {
        UserTimeZoneService.addUserTimeZone(nickName: self.nickNameField.text, location: self.selectedCity, timezone: self.selectedTimeZone)
        self.dismiss(animated: true) {
            (self.navigationController as? CornerRoundedNavigationController)?.onDismiss?()
        }
    }
}
