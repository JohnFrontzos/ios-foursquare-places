//
//  DataService.swift
//  First iOS App
//
//  Created by Ioannis Frontzos on 8/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import Foundation

class DataService {
    static let shared = DataService()
    
    // https://api.foursquare.com/v2/venues/search?client_id={{client_id}}&client_secret={{client_secret}}&v={{v}}&ll=40.7099,-73.9622&radius=10000
    func fetchPlaces(swLatitude: Double,
                     swLongitude: Double,
                     neLatitude: Double,
                     neLongitude: Double,
                     completion: @escaping (Result<[Place], Error>) -> Void){
        
        if(Constants.foursquareKey.isEmpty || Constants.foursquareSecret.isEmpty){
            print("You must provide a Foursquare key and secret")
            return
        }
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = "api.foursquare.com"
        componentUrl.path = "/v2/venues/search"
        componentUrl.queryItems = [URLQueryItem.init(name: "intent", value: "browse"),
                                   URLQueryItem.init(name: "sw", value: "\(swLatitude),\(swLongitude)"),
                                   URLQueryItem.init(name: "ne", value: "\(neLatitude),\(neLongitude)"),
                                   URLQueryItem.init(name: "client_id", value: Constants.foursquareKey),
                                   URLQueryItem.init(name: "client_secret", value: Constants.foursquareSecret),
                                   URLQueryItem.init(name: "v", value: Constants.foursquareVersion),
                                   URLQueryItem.init(name: "limit", value: "30"),
                                   URLQueryItem.init(name: "categoryId", value: "4bf58dd8d48988d116941735,4d4b7105d754a06374d81259")]
        
        guard let validUrl = componentUrl.url else {
            print("URL creation failed")
            return
        }
        
        URLSession.shared.dataTask(with: validUrl) { (data, response, error) in
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(VenueResponse.self, from: validData)
                completion(.success(response.response.venues.map{$0.toPlace()}))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
        
    }
    
}
