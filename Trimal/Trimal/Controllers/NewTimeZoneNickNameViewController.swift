//
// Created by Zhou, Hongfei on 9/21/18.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class NewTimeZoneNickNameViewController: UIViewController {
    var city: String = ""
    var timezone: TimeZone!

    var cityLabel: UILabel = UILabel()
    var selectedCityLabel: UILabel = UILabel()
    var countryLabel: UILabel = UILabel()
    var selectedCountryLabel: UILabel = UILabel()
    var timeZoneLabel: UILabel = UILabel()
    var currentTimeLabel: UILabel = UILabel()
    var nickNameLabel: UILabel = UILabel()
    var nickNameField: UITextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.cityLabel.text = "City"
        self.cityLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(self.cityLabel)
        self.view.addSubview(self.selectedCityLabel)

        self.countryLabel.text = "Country/Area"
        self.countryLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(self.countryLabel)
        self.view.addSubview(self.selectedCountryLabel)

        self.timeZoneLabel.text = "Time"
        self.timeZoneLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(self.timeZoneLabel)
        self.view.addSubview(self.currentTimeLabel)

        self.nickNameLabel.text = "Nickname for this timezone? (Optional)"
        self.nickNameLabel.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(self.nickNameLabel)
        self.nickNameField.placeholder = "Timezone nickname"
        self.view.addSubview(self.nickNameField)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveNewTimeZone))

        loadViewData()
    }

    func loadViewData() {
        if let city = self.city.split(separator: ",").first?.trimmingCharacters(in: .whitespaces),
           let country = self.city.split(separator: ",").last?.trimmingCharacters(in: .whitespaces) {
            self.selectedCityLabel.text = String(city)
            self.selectedCountryLabel.text = String(country)
        }
        self.timezone = TimeZoneService.getTimeZone(for: self.city)
        self.navigationItem.title = city.split(separator: ",").first?.capitalized
        self.currentTimeLabel.text = DateUtil.formatTime(time: DateUtil.currentTime(), with: self.timezone)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.cityLabel.pin.left(5%).marginTop(30).height(30).width(40%)
        self.selectedCityLabel.pin.after(of: self.cityLabel, aligned: .center).height(of: self.cityLabel).right()
        self.countryLabel.pin.below(of: self.cityLabel, aligned: .left).width(40%).height(30)
        self.selectedCountryLabel.pin.after(of: self.countryLabel, aligned: .center).height(of: self.countryLabel).right()
        self.timeZoneLabel.pin.below(of: self.countryLabel, aligned: .left).width(40%).height(30)
        self.currentTimeLabel.pin.after(of: self.timeZoneLabel, aligned: .center).height(of: self.timeZoneLabel).right()
        self.nickNameLabel.pin.below(of: self.timeZoneLabel, aligned: .left).marginTop(15).height(20).horizontally()
        self.nickNameField.pin.below(of: self.nickNameLabel, aligned: .left).height(30).horizontally()
    }

    @IBAction func saveNewTimeZone() {
        UserTimeZoneService.addUserTimeZone(nickName: self.nickNameField.text, location: self.city, timezone: self.timezone)
        self.dismiss(animated: true) {
            (self.navigationController as? CornerRoundedNavigationController)?.onDismiss?()
        }
    }
}
