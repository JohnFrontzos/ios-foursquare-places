//
//  Location.swift
//  First iOS App
//
//  Created by Ioannis Frontzos on 11/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import Foundation

class UserLocation {
    
    static let shared = UserLocation()
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    private init(){}
}
