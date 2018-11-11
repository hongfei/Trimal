//
// Created by Zhou, Hongfei on 9/6/18.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeDisplay: UIView {
    public static let HEIGHT = CGFloat(75)
    var hasNickName: Bool = false

    var timeLabel = UILabel()
    var dateLabel = UILabel()
    var nickNameLabel = UILabel()
    var locationNameLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        self.dateLabel.font = FontUtil.pingFangTCRegular(size: 17)
        self.dateLabel.textColor = UIColor.darkGray
        self.dateLabel.textAlignment = .right
        self.addSubview(self.dateLabel)

        self.timeLabel.font = FontUtil.pingFangTCRegular(size: 45)
        self.timeLabel.textAlignment = .right
        self.timeLabel.adjustsFontSizeToFitWidth = true
        self.timeLabel.minimumScaleFactor = 0.3
        self.addSubview(self.timeLabel)

        self.nickNameLabel.font = FontUtil.pingFangTCRegular(size: 35)
        self.nickNameLabel.adjustsFontSizeToFitWidth = true
        self.nickNameLabel.minimumScaleFactor = 0.3
        self.addSubview(self.nickNameLabel)

        self.locationNameLabel.font = FontUtil.pingFangTCRegular(size: 17)
        self.locationNameLabel.textColor = UIColor.darkGray
        self.addSubview(self.locationNameLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.dateLabel.pin.top(pin.safeArea).right(pin.safeArea).width(55%).height(25)
        self.timeLabel.pin.below(of: self.dateLabel, aligned: .right).width(40%).height(50)

        if self.hasNickName {
            self.locationNameLabel.isHidden = false
            self.locationNameLabel.pin.left(pin.safeArea).top(pin.safeArea).height(25).before(of: self.dateLabel).marginRight(10)
            self.nickNameLabel.pin.below(of: self.locationNameLabel, aligned: .left).before(of: self.timeLabel).marginRight(10).height(50)
        } else {
            self.nickNameLabel.pin.left(pin.safeArea).before(of: self.timeLabel, aligned: .top).marginRight(10).height(40)
            self.locationNameLabel.isHidden = true
        }
    }

    func loadViewData(timezone: UserTimeZone, time: Date) {
        if let nick = timezone.nickName {
            self.nickNameLabel.text = nick
            self.locationNameLabel.text = timezone.location
            self.hasNickName = true
        } else {
            self.nickNameLabel.text = timezone.location
            self.locationNameLabel.text = nil
            self.hasNickName = false
        }
        self.dateLabel.text = DateUtil.formatDate(time: time, with: timezone.timezone)
        self.timeLabel.text = DateUtil.formatTime(time: time, with: timezone.timezone)
        self.setNeedsLayout()
    }

    func onTimeUpdate(timezone: UserTimeZone, time: Date) {
        self.dateLabel.text = DateUtil.formatDate(time: time, with: timezone.timezone)
        self.timeLabel.text = DateUtil.formatTime(time: time, with: timezone.timezone)
    }
}
