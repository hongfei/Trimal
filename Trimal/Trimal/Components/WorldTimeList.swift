//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit

class WorldTimeList: UITableView, UITableViewDataSource, UITableViewDelegate {
    var timezones: [UserTimeZone] = []
    var expandedCellIndex = -1
    var showingAdjustedTime = false

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
            worldTimeCell.loadViewData(timezone: self.timezones[indexPath.row], showAdjuster: self.expandedCellIndex == indexPath.row)
            TimeCenterService.register(sender: indexPath.row, listener: worldTimeCell)
            return worldTimeCell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == self.expandedCellIndex {
            return WorldTimeCell.HEIGHT + WorldTimeSlider.HEIGHT
        } else {
            return WorldTimeCell.HEIGHT
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previous = IndexPath(item: self.expandedCellIndex, section: 0)
        self.expandedCellIndex = indexPath.row == previous.row ? -1 : indexPath.row
        tableView.reloadRows(at: [previous, indexPath], with: .automatic)
    }

    func loadViewData(timezones: [UserTimeZone]) {
        self.timezones = timezones
        self.reloadData()
    }
}

protocol WorldTimeListDelegate {
}