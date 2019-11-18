//
//  MapUIViewController.swift
//  First iOS App
//
//  Created by Ioannis Frontzos on 11/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import UIKit
import GoogleMaps

class MapUIViewController: UIViewController, GMSMapViewDelegate, SendFilterProtocol {
    
    
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func setFilters() {
        renderMarkers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFilterSegue"
        {
            if let destinationVC = segue.destination as? PlaceTypeListViewController {
                destinationVC.delegate = self
                
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        removePreview()
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        removePreview()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        removePreview()
        
        let place = (marker.userData as! Place)
        let preview: PlacePreview = UIView.fromNib()
        
        let height = view.frame.size.height
        preview.frame = CGRect(x: 0, y: height - 150 , width: 300, height: 50)
        preview.center.x = self.view.center.x
        preview.name.text = place.name
        preview.type.text = place.type
        preview.distance.text = String(format: "%.1f km", CLLocation(latitude: place.latitude, longitude: place.longitude).distance(from: CLLocation(latitude: UserLocation.shared.latitude, longitude: UserLocation.shared.longitude))/1000)
        let centerMap = String(format: ListViewController.MAPBOX_PARAM_CENTER, place.longitude, place.latitude, 15)
        let size = String(format: ListViewController.MAPBOX_PARAM_SIZE, 320, 138)
        let url = ("\(ListViewController.MAPBOX_BASE_URL)\(centerMap)\(size)\(ListViewController.MAPBOX_ACCESSO_TOKEN)")
        preview.image.downloaded(from: url)
        preview.tag = 100
        self.view.addSubview(preview)
        return true
    }
    
    func removePreview(){
        let info = self.view.viewWithTag(100)
        info?.removeFromSuperview()
    }
    
    func request(){
        checkAPIkeys()
    
        DataService.shared.fetch{ (result) in
            switch result {
            case .success(let places):
                Places.shared.places = places
                for place in places {
                    TypesFilter.shared.types[place.type] = true
                }
                self.renderMarkers(updateCamera: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func renderMarkers(updateCamera: Bool = false){
        var bounds = GMSCoordinateBounds()
        DispatchQueue.main.async {
            self.mapView.clear()
            for place in Places.shared.places {
                if(TypesFilter.shared.types[place.type]!) {
                    let position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                    let marker = GMSMarker(position: position)
                    marker.map = self.mapView
                    marker.userData = place
                    bounds = bounds.includingCoordinate(marker.position)
                }
            }
            if(updateCamera) {
                let update = GMSCameraUpdate.fit(bounds, withPadding: 100)
                self.mapView.animate(with: update)
            }
            
        }
    }
    
    func checkAPIkeys(){
        if(Constants.foursquareKey.isEmpty || Constants.foursquareSecret.isEmpty || Constants.gMapsKey.isEmpty || Constants.mapboxtoken.isEmpty) {
            print("You need to add the API keys")
            let alert = UIAlertController(title: "Error", message: "You need to add the API keys", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}

extension MapUIViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        request()
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            UserLocation.shared.latitude = location.coordinate.latitude
            UserLocation.shared.longitude = location.coordinate.longitude
        }
        locationManager.stopUpdatingLocation()
    }
    
    
}