//
// Created by Zhou, Hongfei on 8/29/18.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeSliderCell: UICollectionViewCell {
    var timeLabel = UILabel()
    var markLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        self.markLabel.backgroundColor = .black
        self.addSubview(self.markLabel)

        self.timeLabel.textAlignment = .center
        self.timeLabel.backgroundColor = .white
        self.timeLabel.font = FontUtil.pingFangTCLight(size: 15)
        self.addSubview(self.timeLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.markLabel.pin.vertically().hCenter().width(2)
        self.timeLabel.pin.horizontally().vCenter().height(26)
    }

    func loadViewData(hour: String) {
        self.timeLabel.text = hour
    }
}
