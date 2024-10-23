//
//  AddRestaurantView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 10/21/24.
//
import SwiftUI
import SwiftData
import MapKit

struct AddRestaurantView: View {
    @Bindable var menu: Menu
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        Form {
            TextField("Name", text: $menu.label) // TODO: Fancy live querying here. https://stackoverflow.com/questions/35629285/how-to-create-autocomplete-text-field-in-swift/43306951#43306951
            
            // Put map with location here
            Map(position: $position) {
                
            }
            
            Button{
                
            }
            label: {
                Text("Add Restaurant")
            }
        }
        .navigationTitle("New Restaurant")
        .navigationBarTitleDisplayMode(.inline)

    }
}
