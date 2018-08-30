//
// Created by Zhou, Hongfei on 8/29/18.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeSliderCell: UICollectionViewCell {
    var timeLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.timeLabel.textAlignment = .center
        self.addSubview(self.timeLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.timeLabel.pin.all()
    }

    func reloadViewData(position: String) {
        self.timeLabel.text = position
    }
}
