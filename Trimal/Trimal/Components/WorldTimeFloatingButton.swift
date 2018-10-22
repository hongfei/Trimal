//
// Created by Hongfei on 2018/9/6.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit
import PinLayout
import SwiftIcons

class WorldTimeFloatingButton : UIButton {
    let ICON_SIZE: CGFloat = CGFloat(30)
    var backIcon: UIImageView = UIImageView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.opacity = 0.8
        self.layer.shadowRadius = 1.5
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = .zero

        self.backIcon.image = UIImage(icon: .fontAwesomeSolid(.undo), size: CGSize(width: ICON_SIZE, height: ICON_SIZE), textColor: ColorUtil.themeColor)
        self.addSubview(self.backIcon)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.backIcon.pin.width(ICON_SIZE).height(ICON_SIZE).center()
    }
}
