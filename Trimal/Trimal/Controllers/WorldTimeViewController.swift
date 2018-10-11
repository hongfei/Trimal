//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeViewController: UIViewController, WorldTimeListDelegate {
    var worldTimeList = WorldTimeList()
    var backToNowButton = WorldTimeFloatingButton()
    var hideBackToNowButton = true
    var timezones: [UserTimeZone] = []
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.92, green: 0.97, blue: 0.97, alpha: 1)
        self.navigationItem.title = "Time"
        self.setNavigationItems(isEditing: false)

        self.view.addSubview(self.worldTimeList)

        self.backToNowButton.addTarget(self, action: #selector(backToNow), for: .touchUpInside)
        self.view.addSubview(self.backToNowButton)

        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer, forMode: .commonModes)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let pin = self.view.pin
        self.worldTimeList.pin.all(pin.safeArea)

        if self.hideBackToNowButton {
            self.backToNowButton.pin.bottom().marginBottom(-40).hCenter().width(40).height(40)
        } else {
            self.backToNowButton.pin.bottom().marginBottom(40).hCenter().width(40).height(40)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.timezones = UserTimeZoneService.getAllUserTimeZones()
        self.worldTimeList.loadViewData(timezones: self.timezones)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TimeCenterService.toggleTimer(disableTimer: false)
    }

    @IBAction func backToNow() {
        TimeCenterService.toggleTimer(disableTimer: false)
        self.hideBackToNowButton = true
        UIView.animate(withDuration: 0.3) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func timerFired() {
        TimeCenterService.timerPublishTime(time: Date())
        if TimeCenterService.timerDisabled && self.hideBackToNowButton {
            self.hideBackToNowButton = false
            UIView.animate(withDuration: 0.3) {
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func addNewTimeZone() {
        let viewController = NewTimeZoneViewController()
        viewController.cities = TimeZoneService.getAllCities()
        let targetController = CornerRoundedNavigationController(rootViewController: viewController)
        targetController.onDismiss = { self.viewWillAppear(true) }
        self.present(targetController, animated: true)
    }

    @IBAction func editWorldTimeList() {
        self.worldTimeList.setEditing(true, animated: true)
        setNavigationItems(isEditing: true)
    }

    @IBAction func finishedEditing() {
        self.worldTimeList.setEditing(false, animated: true)
        setNavigationItems(isEditing: false)
    }

    func setNavigationItems(isEditing: Bool) {
        if isEditing {
            self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finishedEditing)), animated: true)
            self.navigationItem.setLeftBarButton(nil, animated: true)
        } else {
            self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTimeZone)), animated: true)
            self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editWorldTimeList)), animated: true)
        }
    }
}
