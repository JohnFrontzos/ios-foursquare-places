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
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private var locationManager = CLLocationManager()
    var delegate : LocationUpdateProtocol!
    
    var currentLocation : CLLocation?
    
    private override init () {
        super.init()
        self.locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//            request()
            guard status == .authorizedWhenInUse else {
                return
            }
            locationManager.startUpdatingLocation()
//            mapView.isMyLocationEnabled = true
        }
    
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                currentLocation = location
                self.delegate.didUpdate(location: location)
    
            }
            locationManager.stopUpdatingLocation()
        }
    
//    // MARK: - CLLocationManagerDelegate
//    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
//        currentLocation = newLocation
//        let userInfo : NSDictionary = ["location" : currentLocation!]
//
//        dispatch_async(dispatch_get_main_queue()) { () -> Void in
//            self.delegate.locationDidUpdateToLocation(self.currentLocation!)
//            NSNotificationCenter.defaultCenter().postNotificationName(kLocationDidChangeNotification, object: self, userInfo: userInfo as [NSObject : AnyObject])
//        }
//    }
    
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        request()
//        guard status == .authorizedWhenInUse else {
//            return
//        }
//        locationManager.startUpdatingLocation()
//        mapView.isMyLocationEnabled = true
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            UserLocation.shared.latitude = location.coordinate.latitude
//            UserLocation.shared.longitude = location.coordinate.longitude
//        }
//        locationManager.stopUpdatingLocation()
//    }
}
