//
//  Menu.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 9/17/24.
//

import Foundation
import SwiftData

@Model
final class Menu {
    var label: String
    
    init(label: String) {
        self.label = label
    }
}
