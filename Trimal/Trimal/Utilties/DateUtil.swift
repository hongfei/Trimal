//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import UIKit

class DateUtil {
    static let dateFormatter = DateFormatter()
    static let timeFormatter = DateFormatter()
    public static let calendar = Calendar.current

    public static func formatDate(time: Date, with timezone: TimeZone) -> String {
        dateFormatter.dateFormat = "E, MMM dd, yyyy"
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: time)
    }

    public static func formatTime(time: Date, with timezone: TimeZone) -> String {
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = timezone
        return timeFormatter.string(from: time)
    }

    public static func currentTime() -> Date {
        return Date()
    }

    public static func timeToOffset(minutes: Int) -> CGFloat {
        let frameWidth = UIScreen.main.bounds.width
        return CGFloat(WorldTimeSlider.TIME_SLOT_COUNT) / 2 * WorldTimeSliderLayout.SLOT_WIDTH + CGFloat(minutes) * 100 / 60 - frameWidth / 2
    }
}
