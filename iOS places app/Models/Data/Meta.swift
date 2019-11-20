//
//  Meta.swift
//  iOS places app
//
//  Created by Ioannis Frontzos on 20/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import Foundation

struct Meta: Codable {
    let code: Int
    let requestID: String

    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}
