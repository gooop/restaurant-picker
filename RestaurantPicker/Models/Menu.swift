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
}
