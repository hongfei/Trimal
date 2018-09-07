//
// Created by Hongfei on 2018/9/6.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit

class CornerRoundedNavigationController: UINavigationController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        self.navigationBar.layer.cornerRadius = 10
        self.navigationBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.navigationBar.clipsToBounds = true
        self.navigationBar.isTranslucent = false
        self.modalPresentationStyle = .overCurrentContext
    }
}
