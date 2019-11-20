//
//  Venue.swift
//  iOS places app
//
//  Created by Ioannis Frontzos on 20/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import Foundation

struct Venue: Codable {
    let id, name: String
    let location: Location
    let categories: [Category]

    enum CodingKeys: String, CodingKey {
        case id, name, location, categories
    }
    
    func toPlace() -> Place{
        Place(id: self.id, name: self.name, type: self.categories[0].name, latitude: self.location.lat, longitude: self.location.lng)
    }
}
