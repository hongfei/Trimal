//
// Created by Hongfei on 2018/9/6.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout

class WorldTimeFloatingButton : UIButton {
    var buttonText = UILabel()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .gray
        self.layer.cornerRadius = 20
        self.layer.opacity = 0.8
        self.layer.shadowRadius = 3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1, height: 1)

        self.buttonText.text = "Now"
        self.buttonText.font = FontUtil.font(of: 25)
        self.buttonText.textColor = .white
        self.buttonText.textAlignment = .center
        self.addSubview(self.buttonText)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.buttonText.pin.all()
    }
}
