//
//  Category.swift
//  iOS places app
//
//  Created by Ioannis Frontzos on 20/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import Foundation

struct Category: Codable {
    let id, name, pluralName, shortName: String
    let icon: Icon
    let primary: Bool
}
