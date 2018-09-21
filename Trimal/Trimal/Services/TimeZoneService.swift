//
// Created by Hongfei on 2018/9/20.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import Foundation

class TimeZoneService {
    static func getAllCities() -> [String] {
        return Array(TimeZoneRepository.timeZoneDict().keys).sorted()
    }

    static func getTimeZone(for city: String) -> TimeZone? {
        return TimeZoneRepository.timeZoneDict()[city]
    }
}
