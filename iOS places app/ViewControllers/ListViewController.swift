//
//  ListViewController.swift
//  First iOS App
//
//  Created by Ioannis Frontzos on 10/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import UIKit
import CoreLocation

class ListViewController: UITableViewController {
    
    var places = [Place]()
    let cellIdentifier = "PlaceTableViewCell"
    
    static let MAPBOX_BASE_URL = "https://api.mapbox.com/styles/v1/mapbox/satellite-v9/static"
    static let MAPBOX_PARAM_CENTER = "/%f,%f,%d.0,0,0"
    static let MAPBOX_PARAM_SIZE = "/%dx%d"
    static let MAPBOX_ACCESSO_TOKEN = "?access_token=\(Constants.mapboxtoken)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        places = Places.shared.places
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if places.count == 0 {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlaceTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PlaceTableViewCell.")
        }
        
        let place = places[indexPath.row]
        cell.name.text = place.name
        cell.type.text = place.type.capitalized
        
        cell.distance.text = String(format: "%.1f km",CLLocation(latitude: place.latitude, longitude: place.longitude).distance(from: CLLocation(latitude: UserLocation.shared.latitude, longitude: UserLocation.shared.longitude))/1000)
        
        let centerMap = String(format: ListViewController.MAPBOX_PARAM_CENTER, place.longitude, place.latitude, 15)
        let size = String(format: ListViewController.MAPBOX_PARAM_SIZE, 100, 90)
        let url = ("\(ListViewController.MAPBOX_BASE_URL)\(centerMap)\(size)\(ListViewController.MAPBOX_ACCESSO_TOKEN)")
        cell.placeImage?.downloaded(from: url)
        return cell
    }
}
