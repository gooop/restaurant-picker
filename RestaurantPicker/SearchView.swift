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
    
    // Vars for restaurant picking
    @State private var currentStreak: Int = 0
    @State private var longestStreak: (MKMapItem, Int)? = nil // Restaurant that lasted the longest
    
    // View body
    var body: some View {
        VStack {
            Map(position: $position) {
                ForEach(searchResults, id: \.self) { result in
                    Marker(item: result)
                }
                
                UserAnnotation()
            }
            .mapStyle(.standard(elevation: .realistic))
            .safeAreaInset(edge: .bottom) {
                VStack {
                    HStack {
                        Spacer()
                        RestaurantSearchButton(searchResults: $searchResults, visibleRegion: visibleRegion)
                            .padding(.top)
                        Spacer()
                    }
                    HStack {
                        if searchResults != [] && searchResults.count > 1 {
                            Spacer()
                            Button(action: {
                                popOtherRestaurant(index: 1, list: &searchResults)
                            }) {
                                Text(searchResults[0].name ?? "Unknown")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            Spacer()
                            Spacer()
                            Button(action: {
                                popOtherRestaurant(index: 0, list: &searchResults)
                            }) {
                                Text(searchResults[1].name ?? "Unknown")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            Spacer()
                        }
                    }
                }
                .background(.thinMaterial)
            }
            .onChange(of: searchResults) {
                position = .automatic
            }
            .onMapCameraChange { context in
                visibleRegion = context.region
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
    

