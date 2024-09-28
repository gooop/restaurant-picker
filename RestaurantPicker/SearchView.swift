//
//  SearchView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 9/12/24.
//

import SwiftUI
import Foundation
import MapKit

struct SearchView: View {
    // Map position vars
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var visibleRegion: MKCoordinateRegion?
    
    // Map item vars
    @State private var searchResults: [MKMapItem] = []
    @State private var selectedMark: MKMapItem?
    
    // Vars for restaurant picking
    @State private var currentStreak: Int = 0
    @State private var longestStreak: (MKMapItem, Int)? = nil // Restaurant that lasted the longest
    
    // View body
    var body: some View {
        ZStack {
            Map(position: $position, selection: $selectedMark) {
                ForEach(searchResults, id: \.self) { result in
                    Marker(item: result)
                        .tag(result)
                }
                UserAnnotation()
            }
            .mapControls{
                MapUserLocationButton()
                MapCompass()
            }
            .mapStyle(.standard(elevation: .realistic))
            .onChange(of: searchResults) {
                position = .automatic
            }
            .onMapCameraChange { context in
                visibleRegion = context.region
            }
            .overlay(alignment: .bottomTrailing) {
                RestaurantSearchButton(searchResults: $searchResults, visibleRegion: visibleRegion)
                    .padding(.all)
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    if searchResults != [] && searchResults.count > 1 {
                        Spacer()
                        RestaurantButton(
                            restaurant: searchResults[0],
                            action: {popOtherRestaurant(index: 1, list: &searchResults)}
                        )
                        .background(.thinMaterial)
                        .padding(.all)
                        Spacer()
                        Spacer()
                        RestaurantButton(
                            restaurant: searchResults[1],
                            action: {popOtherRestaurant(index: 0, list: &searchResults)}
                        )
                        .background(.thinMaterial)
                        .padding(.all)
                        Spacer()
                    }
                    else {
                        // HStack is empty
                    }
                }
            }
        }
    }
    
        /// Helper to remove the restaurant  that was not selected from the list
        private func popOtherRestaurant(index: Int, list: inout [MKMapItem]) {
            guard list.count > 1 else { return }
            
            // Remove the non-selected restaurant
            list.remove(at: index == 0 ? 0 : 1)
        }
    }
    

