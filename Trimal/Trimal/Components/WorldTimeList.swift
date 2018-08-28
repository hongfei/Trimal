//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit

class WorldTimeList: UITableView, UITableViewDataSource, UITableViewDelegate {
    var timezones: [UserTimeZone] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)

        self.dataSource = self
        self.delegate = self
        self.tableFooterView = UIView(frame: CGRect.zero)
        self.register(WorldTimeCell.self, forCellReuseIdentifier: "WorldTimeCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timezones.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorldTimeCell") else {
            return UITableViewCell()
        }

        if let worldTimeCell = cell as? WorldTimeCell {
            let locale = self.timezones[indexPath.row]
            worldTimeCell.loadViewData(date: Date(), timezone: self.timezones[indexPath.row])
            return worldTimeCell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WorldTimeCell.HEIGHT
    }
    
    func loadViewData(timezones: [UserTimeZone]) {
        self.timezones = timezones
        self.reloadData()
    }
}

protocol WorldTimeListDelegate {
    func onTimeSelected()
}