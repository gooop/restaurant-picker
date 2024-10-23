//
//  EditMenuView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 9/29/24.
//

import SwiftUI
import SwiftData

struct EditMenuView: View {
    @Bindable var menu: Menu
    
    var body: some View {
        Form {
            TextField("Name", text: $menu.label)
            
            Section("Restaurants") {
            NavigationLink(destination: {
                AddRestaurantView(
                    menu: menu
                )
                }, label: {
                    Text("Add Restaurant")
                        .foregroundColor(Color.accentColor)
                })
            List (menu.places, id: \.self) { place in
                NavigationLink(destination: {
                    RestaurantView(
                        restaurant: place
                    )
                    }, label: {
                        Text(place.name ?? "Unknown Place")
                    })
            }
            }
            
        }
        .navigationTitle("Edit Menu")
        .navigationBarTitleDisplayMode(.inline)
    }
}
