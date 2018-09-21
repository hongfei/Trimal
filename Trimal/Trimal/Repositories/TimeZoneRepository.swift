//
// Created by Hongfei on 2018/9/20.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import Foundation

class TimeZoneRepository {
    static func timeZoneDict() -> [String: TimeZone] {
        if let path = Bundle.main.url(forResource: "timezones", withExtension: "plist"), let cities = NSDictionary(contentsOf: path) as? [String: String] {
            return cities.mapValues({ tzName in TimeZone(identifier: tzName)! })
        }
        return [:]
    }
}
