//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import Foundation

class DateUtil {
    static let dateFormatter = DateFormatter()
    static let timeFormatter = DateFormatter()

    public static func formatDate(date: Date, with timezone: TimeZone) -> String {
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: date)
    }

    public static func formatTime(date: Date, with timezone: TimeZone) -> String {
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = timezone
        return timeFormatter.string(from: date)
    }
}
