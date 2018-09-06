//
//  UserTimeZoneRepository.swift
//  Trimal
//
//  Created by Zhou, Hongfei on 9/6/18.
//  Copyright © 2018 Hongfei Zhou. All rights reserved.
//

import Cache

class UserTimeZoneRepository {
    let diskConfig = DiskConfig(name: "UserTimeZoneStore", expiry: .never, protectionType: .complete)

}