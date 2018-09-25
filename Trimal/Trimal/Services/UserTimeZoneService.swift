//
// Created by Zhou, Hongfei on 9/6/18.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import Foundation

class UserTimeZoneService {
    static func addUserTimeZone(nickName: String?, location: String, timezone: TimeZone) {
        guard let subLocationSequence = location.split(separator: ",").first else {
            return
        }

        let subLocation = String(subLocationSequence)
        let userTimeZone = UserTimeZone(nickName: nil, location: subLocation, timezone: timezone)
        if let nick = nickName, !nick.trimmingCharacters(in: .whitespaces).isEmpty {
            userTimeZone.nickName = nick
        }

        UserTimeZoneRepository.addUserTimeZone(timezone: userTimeZone)
    }

    class func getAllUserTimeZones() -> [UserTimeZone] {
        return UserTimeZoneRepository.getAllTimeZones()
    }
}
