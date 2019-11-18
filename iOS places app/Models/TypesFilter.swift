//
//  TypeFilter.swift
//  First iOS App
//
//  Created by Ioannis Frontzos on 13/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import Foundation

class TypesFilter{
    static let shared = TypesFilter()
    
    var types: [String: Bool]
    
    private init(){
        types = [:]
    }
    
}
