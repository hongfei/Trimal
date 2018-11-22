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
        self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)

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

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != self.expandedCellIndex
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedTimeZone = self.timezones[indexPath.row]
            UserTimeZoneService.deleteUserTimeZone(timezone: selectedTimeZone)
            self.timezones.remove(at: indexPath.row)
            
            if self.expandedCellIndex == indexPath.row { self.expandedCellIndex = -1 }
            else if self.expandedCellIndex > indexPath.row { self.expandedCellIndex -= 1 }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedUserTimeZone = self.timezones[sourceIndexPath.row]
        self.timezones.remove(at: sourceIndexPath.row)
        self.timezones.insert(movedUserTimeZone, at: destinationIndexPath.row)
        UserTimeZoneService.saveSortedTimeZones(timezones: self.timezones)
        self.reloadData()
    }

    func loadViewData(timezones: [UserTimeZone]) {
        self.timezones = timezones
        self.reloadData()
    }
}

protocol WorldTimeListDelegate {
}
