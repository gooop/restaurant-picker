//
//  MenuView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 9/12/24.
//

import SwiftUI
import Foundation
import MapKit

struct MenuView: View {
    var menuList = [
        Menu(label: "Latin Food"),
        Menu(label: "Pizza Places"),
        Menu(label: "Everything"),
    ]
    // View body
    var body: some View {
        VStack {
            List {
                ForEach(menuList) { menu in
                    Text(menu.label)
                }
            }
        }
    }
    
    /// Example func definition
    private func dummy() {}
    
}
