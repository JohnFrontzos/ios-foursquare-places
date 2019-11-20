//
//  LocationManager.swift
//  iOS places app
//
//  Created by Ioannis Frontzos on 20/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationUpdateProtocol {
    func didUpdate(location : CLLocation)
    func authorizationDeclined()
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private var locationManager = CLLocationManager()
    var delegate : LocationUpdateProtocol!
    
    var currentLocation : CLLocation?
    
    private override init () {
        super.init()
        self.locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            self.delegate.authorizationDeclined()
            return
        }
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            self.delegate.didUpdate(location: location)
            
        }
        locationManager.stopUpdatingLocation()
    }
}
