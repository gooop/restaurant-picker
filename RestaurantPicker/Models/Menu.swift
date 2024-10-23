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
            zip(latitudes, longitudes).map { lat, long in
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let placemark = MKPlacemark(coordinate: coordinate)
                return MKMapItem(placemark: placemark)
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
         placeNames: [String] = ["hello"],
         latitudes: [Double] = [0.0],
         longitudes: [Double] = [0.0]) {
        self.label = label
        self.placeNames = placeNames
        self.latitudes = latitudes
        self.longitudes = longitudes
    }
}
