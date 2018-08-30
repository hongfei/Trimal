//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Z?h?ou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeCell: UITableViewCell {
    public static let HEIGHT = CGFloat(100)
    var hasNickName: Bool = false
    var showAdjuster: Bool = false
    var timeLabel =  UILabel()
    var dateLabel = UILabel()
    var nickNameLabel = UILabel()
    var locationNameLabel = UILabel()
    var timeAdjuster = WorldTimeSlider()

    override var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsetsMake(10, 15, 10, 20)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let view = self.contentView
        self.dateLabel.font = FontUtil.font(of: 17)
        self.dateLabel.textAlignment = .right

        view.addSubview(self.dateLabel)

        self.timeLabel.font = FontUtil.font(of: 45)
        self.timeLabel.textAlignment = .right
        view.addSubview(self.timeLabel)

        self.nickNameLabel.font = FontUtil.font(of: 35)
        self.nickNameLabel.adjustsFontSizeToFitWidth = true
        self.nickNameLabel.minimumScaleFactor = 0.3
        view.addSubview(self.nickNameLabel)

        self.locationNameLabel.font = FontUtil.font(of: 17)
        view.addSubview(self.locationNameLabel)

        self.addSubview(self.timeAdjuster)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let pin = self.contentView.pin

        self.dateLabel.pin.top(pin.safeArea).right(pin.safeArea).width(140).height(25)
        self.timeLabel.pin.below(of: self.dateLabel, aligned: .right).width(140).height(50)

        if self.hasNickName {
            self.locationNameLabel.isHidden = false
            self.locationNameLabel.pin.left(pin.safeArea).top(pin.safeArea).height(25).before(of: self.dateLabel).marginRight(10)
            self.nickNameLabel.pin.below(of: self.locationNameLabel, aligned: .left).before(of: self.timeLabel).marginRight(10).height(50)
        } else {
            self.nickNameLabel.pin.left(pin.safeArea).before(of: self.timeLabel, aligned: .top).marginRight(10).height(35)
            self.locationNameLabel.isHidden = true
        }

        if self.showAdjuster {
            self.timeAdjuster.isHidden = false
            self.timeAdjuster.pin.bottom().horizontally().height(WorldTimeSlider.HEIGHT)
        } else {
            self.timeAdjuster.isHidden = true
        }
    }

    func loadViewData(date: Date, timezone: UserTimeZone, showAdjuster: Bool) {
        if let nick = timezone.nickName {
            self.nickNameLabel.text = nick
            self.locationNameLabel.text = timezone.location
            self.hasNickName = true
        } else {
            self.nickNameLabel.text = timezone.location
            self.locationNameLabel.text = nil
            self.hasNickName = false
        }
        self.dateLabel.text = DateUtil.formatDate(date: date, with: timezone.timezone)
        self.timeLabel.text = DateUtil.formatTime(date: date, with: timezone.timezone)
        self.showAdjuster = showAdjuster

        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
