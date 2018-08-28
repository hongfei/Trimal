//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeCell: UITableViewCell {
    var timeLabel =  UILabel()
    var dateLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let view = self.contentView
        view.addSubview(self.timeLabel)
        view.addSubview(self.dateLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let pin = self.contentView.pin
        self.dateLabel.pin.top(pin.safeArea).right(pin.safeArea).width(50%).height(30)
        self.timeLabel.pin.below(of: self.dateLabel, aligned: .right).width(50%).height(50)
    }

    func loadViewData(dateTime: DateTime, with locale: Locale) {
        self.dateLabel.text = DateUtil.formatDate(date: dateTime.date, with: locale)
        self.timeLabel.text = DateUtil.formatTime(date: dateTime.date, with: locale)
    }
}
