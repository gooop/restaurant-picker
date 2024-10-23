//
//  RestaurantView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 10/22/24.
//
import SwiftUI
import SwiftData
import MapKit

struct RestaurantView: View {
    @State var restaurant: MKMapItem
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        ScrollView {
            VStack {
                // Put map with location here
                Map(position: $position)
                .cornerRadius(30)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 350, maxHeight: 500)
                Text(restaurant.name ?? "Unknown Restaurant")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                Text(restaurant.description)
                    .font(.body)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(minHeight: 0, maxHeight: .infinity)
        .navigationTitle(restaurant.name ?? "Unknown Restaurant")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

