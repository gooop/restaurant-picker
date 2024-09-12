//
//  ContentView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 6/16/24.
//

import SwiftUI
import MapKit
import SwiftData

extension CLLocationCoordinate2D {
    static let defaultLoc = CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903)
}

struct MainView: View {
    // Setup vars
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.modelContext) private var modelContext
    // Code to prevent preview crashing
    var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
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
        .onAppear {
            // Check to prevent preview crashing
            if !isPreview {
                checkAndRequestLocationPermission()
            }
        }
    }
    
    /// Helper to remove the restaurant  that was not selected from the list
    private func popOtherRestaurant(index: Int, list: inout [MKMapItem]) {
        guard list.count > 1 else { return }
        
        // Remove the non-selected restaurant
        list.remove(at: index == 0 ? 0 : 1)
    }
    
    /// Helper for requesting location permission
    private func checkAndRequestLocationPermission() {
            guard let status = locationManager.authorizationStatus else {
                locationManager.requestLocationPermission()
                return
            }
            
            switch status {
            case .notDetermined:
                locationManager.requestLocationPermission()
            case .restricted, .denied:
                () // do nothing
            case .authorizedWhenInUse, .authorizedAlways:
                () // do nothing
            @unknown default:
                locationManager.requestLocationPermission()
            }
        }
}

#Preview {
    MainView()
        .modelContainer(for: Item.self, inMemory: true)
}
