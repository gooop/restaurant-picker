//
//  Menu.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 9/17/24.
//

import Foundation
import SwiftData
import MapKit

@Model
final class Menu {
    var label: String
    
    // Store location data separately since MKMapItem isn't Codable
    var placeNames: [String]
    var latitudes: [Double]
    var longitudes: [Double]
    
    // Computed property to generate MKMapItem
    var places: [MKMapItem] {
        get {
            zip(placeNames, zip(latitudes, longitudes)).map { name, locZip in
                let lat = locZip.0
                let long = locZip.1
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let name = name
                let placemark = MKPlacemark(coordinate: coordinate)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = name
                return mapItem
            }
        }
        set (mapItems) {
            for mapItem in mapItems {
                placeNames.append(mapItem.placemark.name ?? "Unknown Place")
                latitudes.append(mapItem.placemark.coordinate.latitude)
                longitudes.append(mapItem.placemark.coordinate.longitude)
            }
        }
    }
        
    init(label: String = "",
         placeNames: [String] = [],
         latitudes: [Double] = [],
         longitudes: [Double] = []) {
        self.label = label
        self.placeNames = placeNames
        self.latitudes = latitudes
        self.longitudes = longitudes
    }
    
    public func addPlace(place: MKMapItem) {
        latitudes.append(place.placemark.coordinate.latitude)
        longitudes.append(place.placemark.coordinate.longitude)
        placeNames.append(place.name ?? "Unknown Place")
    }
    
    public func clearPlaces() {
        placeNames = []
        latitudes = []
        longitudes = []
        places = []
    }
}
