//
//  UserTimeZoneRepository.swift
//  Trimal
//
//  Created by Zhou, Hongfei on 9/6/18.
//  Copyright © 2018 Hongfei Zhou. All rights reserved.
//

import Cache

class UserTimeZoneRepository {
    static let STORAGE_KEY = "UserTimeZoneStorage"
    static let diskConfig = DiskConfig(name: "UserTimeZoneStore", expiry: .never, protectionType: .complete)
    static let userTimeZoneStorage: DiskStorage<[UserTimeZone]>? = try? DiskStorage(config: diskConfig, transformer: TransformerFactory.forCodable(ofType: [UserTimeZone].self))

    static func addUserTimeZone(timezone: UserTimeZone) {
        if let storage = userTimeZoneStorage, let timezones = try? storage.object(forKey: STORAGE_KEY) {
            storeTimeZones(timezones + [timezone])
        } else {
            storeTimeZones([timezone])
        }
    }

    static func storeTimeZones(_ timezones: [UserTimeZone]) {
        if let storage = userTimeZoneStorage {
            try? storage.setObject(timezones, forKey: STORAGE_KEY)
        }
    }

    static func getAllTimeZones() -> [UserTimeZone] {
        if let storage = userTimeZoneStorage, let timezones = try? storage.object(forKey: STORAGE_KEY) {
            return timezones
        } else {
            return []
        }
    }

    static func deleteTimeZone(timezone: UserTimeZone) {
        if let storage = userTimeZoneStorage, let timezones = try? storage.object(forKey: STORAGE_KEY) {
            let timezonesAfterDeletion = timezones.filter({ tz in timezone.nickName != tz.nickName && timezone.location != tz.location })
            storeTimeZones(timezonesAfterDeletion)
        }
    }
}