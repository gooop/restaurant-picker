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
    //var place: MKMapItem
    var rating: Int
    
    init(label: String = "", rating: Int = 0) {
        self.label = label
        self.rating = rating
    }
}
