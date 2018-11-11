//
// Created by Hongfei on 2018/9/20.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class NewTimeCityListCell: UITableViewCell {
    var cityName: UILabel = UILabel()
    
    override var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsetsMake(5, 15, 5, 10)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.cityName.font = FontUtil.pingFangTCRegular(size: 17)
        self.addSubview(self.cityName)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.cityName.pin.all(pin.safeArea)
    }

    func loadViewData(cityName: String) {
        self.cityName.text = cityName
    }
}
