//
//  Place.swift
//  First iOS App
//
//  Created by Ioannis Frontzos on 11/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import Foundation

class Places {
    
    static let shared = Places()
    
    var places: [Place]
    
    private init(){
        places = []
    }
}
