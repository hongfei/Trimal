//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import Foundation

class DateUtil {
    static let dateFormatter = DateFormatter()
    static let timeFormatter = DateFormatter()

    public static func formatDate(date: Date, with locale: Locale) -> String {
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.locale = locale
        return dateFormatter.string(from: date)
    }

    public static func formatTime(date: Date, with locale: Locale) -> String {
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.locale = locale
        return timeFormatter.string(from: date)
    }
}
