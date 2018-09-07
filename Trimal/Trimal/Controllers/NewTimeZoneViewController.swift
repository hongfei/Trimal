//
// Created by Hongfei on 2018/9/6.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit

class NewTimeZoneViewController : UIViewController {
    override var navigationItem: UINavigationItem {
        let navItem = UINavigationItem()
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelNewTimeZone))
        return navItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
    }

    @IBAction func cancelNewTimeZone() {
        self.navigationController?.dismiss(animated: true)
    }
}
