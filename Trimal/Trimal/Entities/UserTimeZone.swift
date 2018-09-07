//
// Created by Zhou, Hongfei on 8/28/18.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import Foundation

class UserTimeZone: Codable {
    var timezone: TimeZone
    var location: String
    var nickName: String?

    init(nickName: String?, location: String, timezone: TimeZone) {
        self.nickName = nickName
        self.location = location
        self.timezone = timezone
    }
}
