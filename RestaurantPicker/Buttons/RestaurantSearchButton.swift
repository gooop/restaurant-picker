//
//  RestaurantSearchButton.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 8/29/24.
//

import SwiftUI
import MapKit

struct RestaurantSearchButton: View {
    
    @Binding var searchResults: [MKMapItem]
    
    var visibleRegion: MKCoordinateRegion?

    var body: some View {
        HStack {
            Button {
                Task {
                    await searchResults = Common.search(for: "restaurant", visibleRegion: visibleRegion)
                }
            } label: {
                Label("Restaurants", systemImage: "fork.knife.circle.fill")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .labelStyle(.iconOnly)
    }


    
    var mycenter = CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903)
        
}
