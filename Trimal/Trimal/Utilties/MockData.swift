//
// Created by Zhou, Hongfei on 8/28/18.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import Foundation

class MockData {
    public static let timezones = [
        UserTimeZone(nickName: "Home", location: "San Francisco", timezone: TimeZone(identifier: "America/Los_Angeles")!),
        UserTimeZone(nickName: nil, location: "London", timezone: TimeZone(identifier: "Europe/London")!),
        UserTimeZone(nickName: "Parents", location: "Shanghai", timezone: TimeZone(identifier: "Asia/Shanghai")!),
        UserTimeZone(nickName: nil, location: "Aucland", timezone: TimeZone(identifier: "Pacific/Auckland")!)
    ]
}
