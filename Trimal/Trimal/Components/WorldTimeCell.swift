//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Z?h?ou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeCell: UITableViewCell, TimeListener {
    public static let HEIGHT = CGFloat(100)
    var timezone: UserTimeZone!

    var showAdjuster: Bool = false
    var time: Date = Date()

    var timeDisplay = WorldTimeDisplay()
    var timeAdjuster = WorldTimeSlider()

    override var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsetsMake(10, 15, 10, 20)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(self.timeDisplay)
        self.addSubview(self.timeAdjuster)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let pin = self.contentView.pin
        self.timeDisplay.pin.horizontally(pin.safeArea).top(pin.safeArea).height(WorldTimeDisplay.HEIGHT)
        if self.showAdjuster {
            self.timeAdjuster.isHidden = false
            self.timeAdjuster.pin.bottom().horizontally().height(WorldTimeSlider.HEIGHT)
        } else {
            self.timeAdjuster.isHidden = true
        }
    }

    func loadViewData(timezone: UserTimeZone, showAdjuster: Bool) {
        let time = TimeCenter.storedTime
        self.timezone = timezone
        self.timeDisplay.loadViewData(timezone: timezone, time: time)
        self.showAdjuster = showAdjuster
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.timeAdjuster.loadViewData(timezone: self.timezone, time: time)
    }

    func onTimeUpdate(time: Date) {
        self.timeDisplay.onTimeUpdate(timezone: self.timezone, time: time)
        self.timeAdjuster.loadViewData(timezone: self.timezone, time: time)
    }
}

protocol WorldTimeCellDelegate {
    func didAdjustToTime(time: Date)
}