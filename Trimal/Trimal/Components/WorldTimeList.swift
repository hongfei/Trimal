//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit

class WorldTimeList: UITableView, UITableViewDataSource, UITableViewDelegate {
    var dateTime: DateTime = DateTime()
    var locales: [Locale] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)

        self.register(WorldTimeCell.self, forCellReuseIdentifier: "WorldTimeCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorldTimeCell") else {
            return UITableViewCell()
        }

        if let worldTimeCell = cell as? WorldTimeCell {
            let locale = self.locales[indexPath.row]
            worldTimeCell.loadViewData(dateTime: self.dateTime, with: locale)
            return worldTimeCell
        } else {
            return UITableViewCell()
        }
    }
}

protocol WorldTimeListDelegate {
    func onTimeSelected()
}