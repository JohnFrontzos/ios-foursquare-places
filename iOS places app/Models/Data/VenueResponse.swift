//
//  Venue.swift
//  iOS places app
//
//  Created by Ioannis Frontzos on 20/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//
import Foundation

struct VenueResponse: Codable {
    let meta: Meta
    let response: ResponseClass
}

struct ResponseClass: Codable {
    let venues: [Venue]
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}
