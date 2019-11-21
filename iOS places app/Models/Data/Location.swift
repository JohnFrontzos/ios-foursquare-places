//
//  Location.swift
//  iOS places app
//
//  Created by Ioannis Frontzos on 20/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import Foundation

// MARK: - Location
struct Location: Codable {
    let lat, lng: Double
    let formattedAddress: [String]
}
