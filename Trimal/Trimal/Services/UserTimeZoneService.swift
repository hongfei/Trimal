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
        let userTimeZone = UserTimeZone(uuid: StringUtil.uuid(), nickName: nil, location: subLocation, timezone: timezone)
        if let nick = nickName, !nick.trimmingCharacters(in: .whitespaces).isEmpty {
            userTimeZone.nickName = nick
        }

        UserTimeZoneRepository.addUserTimeZone(timezone: userTimeZone)
    }

    static func getAllUserTimeZones() -> [UserTimeZone] {
        return UserTimeZoneRepository.getAllTimeZones()
    }
    
    static func deleteUserTimeZone(timezone: UserTimeZone) {
        UserTimeZoneRepository.deleteTimeZone(uuid: timezone.uuid)
    }
}
