//
// Created by Hongfei on 2018/8/27.
// Copyright (c) 2018 Hongfei Zhou. All rights reserved.
//

import Foundation

class DateTime: Codable {
    var date: Date

    init(date: Date) {
        self.date = date
    }

    convenience init() {
        self.init(date: Date())
    }
}
