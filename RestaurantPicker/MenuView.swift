//
//  MenuView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 9/12/24.
//

import SwiftUI
import SwiftData
import MapKit

struct MenuView: View {
    @Query var menus: [Menu]
    
    // View body
    var body: some View {
        NavigationStack {
            List {
                ForEach(menus) { menu in
                    Text(menu.label)
                }
            }
            .navigationTitle("Menus")
        }
    }
    
    /// Example func definition
    private func dummy() {}
    
}
